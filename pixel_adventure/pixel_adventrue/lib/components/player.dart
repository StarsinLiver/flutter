// 플레이어
import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:pixel_adventrue/components/Saw.dart';
import 'package:pixel_adventrue/components/checkpoint.dart';
import 'package:pixel_adventrue/components/chicken.dart';
import 'package:pixel_adventrue/components/collision_block.dart';
import 'package:pixel_adventrue/components/custom_hitbox.dart';
import 'package:pixel_adventrue/components/fruit.dart';
import 'package:pixel_adventrue/components/utils.dart';
import 'package:pixel_adventrue/pixel_adventure.dart';

// 플레이어 상태
enum PlayerState {
  // idle - 움직이지 않음
  // running - 움직임
  idle,
  running,
  jumping,
  falling,
  hit,
  appearing,
  disappearing
}

// 플레이어 움직임
// enum PlayerDirection { left, right, none }

// 여러 애니메이션
// lots of animation  - SpriteAnimationGroupComponent
// HasGameRef
class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, KeyboardHandler, CollisionCallbacks {
  // 플레이어 캐릭터
  String character;

  // super(position: ) - 플레이어 포지션(위치) 정하기
  Player({
    position,
    this.character = 'Ninja Frog',
  }) : super(position: position);

  // 애니메이션
  final double stepTime = 0.05;
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  late final SpriteAnimation jumpingAnimation;
  late final SpriteAnimation fallingAnimation;
  late final SpriteAnimation hitAnimation;
  late final SpriteAnimation appearingAnimation;
  late final SpriteAnimation disappearingAnimation;

  // 플레이어 움직이기
  final double _gravity = 9.0;
  final double _jumpForce = 60; // 260??
  final double _terminalVelocity = 300;
  double horizontalMovement = 0;
  double moveSpeed = 100;
  Vector2 startingPosition = Vector2.zero();
  Vector2 velocity = Vector2.zero();
  bool isOnGround = false;
  bool hasJumped = false;
  bool gotHit = false;
  bool reachedCheckpoint = false;
  List<CollisionBlock> collisionBlocks = [];
  CustomHitbox hitbox = CustomHitbox(
    offsetX: 10,
    offsetY: 4,
    width: 14,
    height: 28,
  );
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    // debugMode = true;

    startingPosition = Vector2(position.x, position.y);
    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
    ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    accumulatedTime = dt;
    while (accumulatedTime >= fixedDeltaTime) {
      if (!gotHit && !reachedCheckpoint) {
        _updatePlayerState();
        _updatePlayerMovement(accumulatedTime);
        _checkHorizontalCollisions();
        _applyGravity(accumulatedTime);
        _checkVerticalCollisions();
      }
      accumulatedTime -= fixedDeltaTime;
    }

    super.update(dt);
  }

  // 플레이어가 키보드를 누룰 시
  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;
    // 키보드 A 키 또는 화살표 왼쪽을 누룰 시 true
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    // 키보드 D 키 또는 화살표 오른쪽을 누룰 시 true
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);

    horizontalMovement += isLeftKeyPressed ? -1 : 0;
    horizontalMovement += isRightKeyPressed ? 1 : 0;

    // 스페이스 바를 누르면 hasJumped = true
    hasJumped = keysPressed.contains(LogicalKeyboardKey.space);
    // print("왼쪽 : $isLeftKeyPressed");
    // print("오른쪽 : $isRightKeyPressed");
    // print("위쪽 : $hasJumped");
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // 플레이어와 과일이 맞닿으면
    if (!reachedCheckpoint) {
      if (other is Fruit) other.collidingWithPlayer();
      if (other is Saw) _response();
      if (other is Chicken) other.collidedWithPlayer();
      if (other is Checkpoint && !reachedCheckpoint) _reachedCheckpoint();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  // 모든 애니메이션 로드
  void _loadAllAnimations() {
    // 애니메이션 생성 - 움직이지 않는 모션
    idleAnimation = _spriteAnimation('Idle', 11);

    // 애니메이션 생성 - running 애니메이션
    runningAnimation = _spriteAnimation('Run', 12);
    jumpingAnimation = _spriteAnimation('Jump', 12);
    fallingAnimation = _spriteAnimation('Fall', 12);
    hitAnimation = _spriteAnimation('Hit', 7)..loop = false;
    appearingAnimation = _specialSpriteAnimation('Appearing', 7);
    disappearingAnimation = _specialSpriteAnimation('Desappearing', 7);

    // Map 자료 구조
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
      PlayerState.jumping: jumpingAnimation,
      PlayerState.falling: fallingAnimation,
      PlayerState.hit: hitAnimation,
      PlayerState.appearing: appearingAnimation,
      PlayerState.disappearing: disappearingAnimation,
    };

    // 현재 움직임
    current = PlayerState.idle;
  }

  // 함수화 - 리팩토링
  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      gameRef.images.fromCache('Main Characters/$character/$state (32x32).png'),
      SpriteAnimationData.sequenced(
        // 애니메이션의 사진의 객수
        amount: amount,
        // 사진의 1장당 스텝 타입
        stepTime: stepTime,
        // 이미지 32 픽셀
        textureSize: Vector2.all(32),
      ),
    );
  }

  // 나중에 리펙토링해야됨
  SpriteAnimation _specialSpriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      gameRef.images.fromCache('Main Characters/$state (96x96).png'),
      SpriteAnimationData.sequenced(
        // 애니메이션의 사진의 객수
        amount: amount,
        // 사진의 1장당 스텝 타입
        stepTime: stepTime,
        // 이미지 32 픽셀
        textureSize: Vector2.all(96),
        loop: false,
      ),
    );
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;

    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    // Check if moving , set running
    if (velocity.x > 0 || velocity.x < 0) {
      playerState = PlayerState.running;
    }

    // Check if Falling , set to falling
    if (velocity.y > 0) playerState = PlayerState.falling;

    // Check if jumping , set to jumping
    if (velocity.y < 0) playerState = PlayerState.jumping;

    current = playerState;
  }

  // 플레이어의 움직임 (키보드 입력)
  void _updatePlayerMovement(double dt) {
    if (hasJumped && isOnGround) _playerJump(dt);

    // optional
    // if(velocity.y > _gravity) isOnGround = false;

    // 위치 변경
    velocity.x = horizontalMovement * moveSpeed;
    position.x += velocity.x * dt;
  }

  void _playerJump(double dt) {
    if (game.playSounds) {
      FlameAudio.play('jump.wav', volume: game.soundVolume);
    }
    velocity.y = -_jumpForce;
    position.y += velocity.y + dt;
    isOnGround = false;
    hasJumped = false;
  }

  void _checkHorizontalCollisions() {
    for (final block in collisionBlocks) {
      // handle collision
      if (!block.isPlatform) {
        if (checkCollisions(this, block)) {
          if (velocity.x > 0) {
            velocity.x = 0;
            position.x = block.x - hitbox.offsetX - hitbox.width;
            break;
          }
          if (velocity.x < 0) {
            velocity.x = 0;
            position.x = block.x + block.width + hitbox.width + hitbox.offsetX;
            break;
          }
        }
      }
    }
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(_jumpForce, _terminalVelocity);
    position.y += velocity.y * dt;
  }

  void _checkVerticalCollisions() {
    for (final block in collisionBlocks) {
      if (block.isPlatform) {
        // handle platform
        if (checkCollisions(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isOnGround = true;
            break;
          }
        }
      } else {
        if (checkCollisions(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isOnGround = true;
            break;
          }
          if (velocity.y < 0) {
            velocity.y = 0;
            position.y = block.y + hitbox.offsetY;
          }
        }
      }
    }
  }

  // 리스폰
  void _response() async {
    if (game.playSounds) FlameAudio.play('hit.wav', volume: game.soundVolume);
    const canMovedDuration = Duration(milliseconds: 400);
    gotHit = true;
    current = PlayerState.hit;

    await animationTicker?.completed;
    animationTicker?.reset();

    // 얼굴 방향을 오른쪽으로 돌리기
    scale.x = 1;
    // Appear 애니메이션은 96 픽셀인데 비해 플레이어는 32 픽셀이라서 뺌
    position = startingPosition - Vector2.all(96 - 64);
    current = PlayerState.appearing;

    await animationTicker?.completed;
    animationTicker?.reset();
    velocity = Vector2.zero();
    position = startingPosition;
    _updatePlayerState();
    // 움직일 수 있게함
    Future.delayed(canMovedDuration, () => gotHit = false);
  }

  void _reachedCheckpoint() async {
    reachedCheckpoint = true;
    if (game.playSounds)
      FlameAudio.play('disappear.wav', volume: game.soundVolume);
    // 플레이어 위치 약간 조정
    if (scale.x > 0) {
      position = position - Vector2.all(32);
    } else if (scale.x < 0) {
      position = position + Vector2(32, -32);
    }
    current = PlayerState.disappearing;

    await animationTicker?.completed;
    animationTicker?.reset();
    // 리셋
    reachedCheckpoint = false;
    // 플레이어를 어디론가 아무데나 보냄
    position = Vector2.all(-640);

    const waitToChangeDuration = Duration(milliseconds: 3);
    Future.delayed(waitToChangeDuration, () => game.loadNextLevel());
  }

  void collidedWithEnemy() {
    _response();
  }
}



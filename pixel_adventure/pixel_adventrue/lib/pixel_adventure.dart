import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:pixel_adventrue/components/jump_button.dart';
import 'package:pixel_adventrue/components/level.dart';
import 'package:pixel_adventrue/components/player.dart';

// HasKeyboardHandlerComponents : keyboardHandler 를 가진 컴포넌트를 사용 중이다.
// DragCallbacks : joystick 사용
// HasCollisionDetection : CollisionCallBack 을 사용중이다.
class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection  , TapCallbacks{
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  // 카메라
  late final CameraComponent cam;

  // 플레이어
  final Player player = Player(character: 'Mask Dude');

  // 조이 스틱
  late JoystickComponent joystick;
  bool showControlls = true;
  List<String> levelNames = ['level-02', 'level-01'];
  int currentLevelIndex = 0;

  // 사운드
  bool playSounds = true;
  double soundVolume = 1.0;

  @override
  FutureOr<void> onLoad() async {
    // load all Images into cache
    await images.loadAllImages();

    // 맵, 캠 불러오기
    _loadLevel();

    if (showControlls) {
      addJoystick();
      add(JumpButton());
    }
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showControlls) {
      updateJoystick();
    }

    super.update(dt);
  }

  // 조이 스틱 추가
  void addJoystick() {
    joystick = JoystickComponent(
      priority: 10,
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Krob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );

    add(joystick);
  }

  // 조이 스틱이 움직이면
  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      case JoystickDirection.up :
        player.hasJumped = true;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }

  void loadNextLevel() {
    if(currentLevelIndex < levelNames.length - 1) {
      currentLevelIndex++;
      _loadLevel();
    } else {
      // 다음 레벨이 없음 ..
      currentLevelIndex = 0;
      _loadLevel();
    }
  }

  void _loadLevel() {
    Future.delayed(const Duration (seconds: 1), () {
      // 맵 생성 및 유저 생성
      final world = Level(
        levelName: levelNames[currentLevelIndex],
        player: player,
      );
      // 캠 화면 생성
      final cam = CameraComponent.withFixedResolution(
          world: world, width: 640, height: 360);
      cam.viewfinder.anchor = Anchor.topLeft;

      addAll([cam, world]);
    });
  }
}

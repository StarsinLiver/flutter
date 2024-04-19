import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:pixel_adventrue/components/custom_hitbox.dart';
import 'package:pixel_adventrue/pixel_adventure.dart';

class Fruit extends SpriteAnimationComponent
    with HasGameRef<PixelAdventure>, CollisionCallbacks {
  final String fruit;

  Fruit({this.fruit = 'Apple', position, size})
      : super(position: position, size: size);

  final double stepTime = 0.05;
  final hitbox = CustomHitbox(
    offsetX: 10,
    offsetY: 10,
    width: 12,
    height: 12,
  );

  bool _collected = false;

  @override
  FutureOr<void> onLoad() {
    // 디버깅 모드 온
    // debugMode = true;
    // 플레이어 뒤에 오도록
    priority = -1;

    // hitbox 생성
    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
      collisionType: CollisionType.passive,
    ));
    // 애니메이션 생성
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Items/Fruits/$fruit.png'),
        SpriteAnimationData.sequenced(
          amount: 17,
          stepTime: stepTime,
          textureSize: Vector2.all(32),
        ));
    return super.onLoad();
  }

  // 플레이어와 맞닿으면
  void collidingWithPlayer() async {
    if (!_collected) {
      _collected = true;
      if(game.playSounds) FlameAudio.play('collect_fruit.wav' , volume: game.soundVolume);
      // 수집 애니메이션 추가
      animation = SpriteAnimation.fromFrameData(
          game.images.fromCache('Items/Fruits/Collected.png'),
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: stepTime,
            textureSize: Vector2.all(32),
            loop: false,
          ));

      await animationTicker?.completed;
      removeFromParent();
    }
  }
}

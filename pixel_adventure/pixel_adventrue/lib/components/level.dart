import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventrue/components/Saw.dart';
import 'package:pixel_adventrue/components/background_tile.dart';
import 'package:pixel_adventrue/components/checkpoint.dart';
import 'package:pixel_adventrue/components/chicken.dart';
import 'package:pixel_adventrue/components/collision_block.dart';
import 'package:pixel_adventrue/components/fruit.dart';
import 'package:pixel_adventrue/components/player.dart';
import 'package:pixel_adventrue/pixel_adventure.dart';

// 컴포넌트 즉 맵을 꾸밀 수 있는 World 클래스
class Level extends World with HasGameRef<PixelAdventure> {
// flame_tiled 라이브러리
  late TiledComponent level;

  final String levelName;
  final Player player;
  List<CollisionBlock> collisionBlocks = [];

  Level({required this.levelName, required this.player});

  @override
  FutureOr<void> onLoad() async {
    // 타일 : 16 x 16
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(16));

    // 맵 추가
    add(level);

    _scrollingBackground();
    _spawningObjects();
    _addCollisions();

    player.collisionBlocks = collisionBlocks;
    return super.onLoad();
  }

  void _scrollingBackground() {
    // Background 레이어 가져오기
    final backgroundLayer = level.tileMap.getLayer('Background');

    const tileSize = 64;

    final numTileY = (game.size.y / tileSize).floor();
    final numTileX = (game.size.x / tileSize).floor();

    if (backgroundLayer != null) {
      final backgroundColor =
          backgroundLayer.properties.getValue('BackgroundColor');

      final backgroundTile = BackgroundTile(
        // color: backgroundColor != null ? backgroundColor : 'Gray',
        color: backgroundColor ?? 'Gray',
        position: Vector2(0, 0),
      );
      add(backgroundTile);
    }
  }

  void _addCollisions() {
    // Collision
    final collisionsLayer = level.tileMap.getLayer<ObjectGroup>('Collisions');
    if (collisionsLayer != null) {
      for (final collisions in collisionsLayer.objects) {
        switch (collisions.class_) {
          case 'Platform':
            final platform = CollisionBlock(
                position: Vector2(collisions.x, collisions.y),
                size: Vector2(collisions.width, collisions.height),
                isPlatform: true);
            // 모든 플랫폼을 리스트에 담는다.
            collisionBlocks.add(platform);
            // 스크린에 담음
            add(platform);
            break;
          default:
            // 플랫폼이 아님
            final block = CollisionBlock(
              position: Vector2(collisions.x, collisions.y),
              size: Vector2(collisions.width, collisions.height),
            );
            collisionBlocks.add(block);
            add(block);
        }
      }
    }
  }

  void _spawningObjects() {
    // 플레이어 스폰 포인트 레이어 - tiled 의 레이어 정의
    final spawnPointLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    if (spawnPointLayer != null) {
      // 스폰 레이어의 오브젝트가 당연히 있다 == !
      for (final spawnPoint in spawnPointLayer!.objects) {
        switch (spawnPoint.class_) {
          // class 가 Player 라면
          case 'Player':
            // tiled 에서 정한 포지션이 정해짐
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            player.scale.x = 1;
            add(player);
            break;
          case 'Fruit':
            final fruit = Fruit(
              fruit: spawnPoint.name,
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height),
            );
            add(fruit);
            break;
          case 'Saw':
            final isVertical = spawnPoint.properties.getValue('isVertical');
            final offNeg = spawnPoint.properties.getValue('offNeg');
            final offPos = spawnPoint.properties.getValue('offPos');
            final saw = Saw(
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height),
              isVertical: isVertical,
              offNeg: offNeg,
              offPos: offPos,
            );
            add(saw);
            break;
          case 'Checkpoint':
            final checkpoint = Checkpoint(
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height),
            );
            add(checkpoint);
            break;
          case 'Chicken':
            final offNeg = spawnPoint.properties.getValue('offNeg');
            final offPos = spawnPoint.properties.getValue('offPos');
            final chicken = Chicken(
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height),
              offNeg: offNeg,
              offPos: offPos,
            );
            add(chicken);
            break;
          default:
        }
      }
    }
  }
}

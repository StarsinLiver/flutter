import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventrue/pixel_adventure.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen(); // 풀 스크린
  await Flame.device.setLandscape(); // 옆으로 누운거

  PixelAdventure game = PixelAdventure();
  runApp(
    GameWidget(game: kDebugMode ? PixelAdventure() : game),
  );
}

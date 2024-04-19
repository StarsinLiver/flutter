import 'package:flame/components.dart';

// PositionComponent - Platform 위치 찾기
class CollisionBlock extends PositionComponent {
  bool isPlatform ;

  CollisionBlock({position, size , this.isPlatform = false}) : super(position: position , size: size) {
    // debugMode = true;
  }

  @override
  String toString() {
    return 'CollisionBlock{isPlatform: $isPlatform}';
  }
}

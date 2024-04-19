import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _Home(),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home({super.key});

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> with SingleTickerProviderStateMixin {

  // AnimationController 타입
  // late 나중에 값을 할당할 것임을 나타냄
  late AnimationController _animationController;

  // 초기화
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: Duration(seconds: 3),
        vsync: this
    );

    // 애니메이션 동작 시키기
    _animationController.repeat();
  }

  // 애니메이션 효과 제외시키기
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    const double smallLogo = 100;
    const double bigLogo = 200;
    
    // 거의 공식
    Animation<double> _animation =
    Tween(begin: 0.0, end: 1.0).animate(
        _animationController
    );

    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final Size biggest = constraints.biggest; // 위치
            // Stack 안에 있어야함
            return Stack(
              children: <Widget>[
                PositionedTransition(
                  rect: RelativeRectTween(
                    // fromSize : 사이즈 줄이기 키우기
                    // fromLTWH : 위치 바꾸기
                    begin: RelativeRect.fromLTRB(
                      0, 0, smallLogo, smallLogo,
                    ),
                    end: RelativeRect.fromSize(
                      Rect.fromLTWH(biggest.width - bigLogo,
                          biggest.height - bigLogo, bigLogo, bigLogo),
                      biggest,
                    ),
                  ).animate(CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.elasticInOut,
                    ),
                  ),
                  child: Image.asset('assets/image.jpeg'),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

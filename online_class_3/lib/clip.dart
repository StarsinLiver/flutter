import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

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

class _Home extends StatelessWidget {
  const _Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            // ClipRRect
            // 각이 둥근 상자를 만듦
            ClipRRect(
              child: Image.asset('assets/image.jpeg'),
              borderRadius: BorderRadius.circular(20.0),
            ),

            // ClipOval
            // 동그란 모양
            ClipOval(
              child: Image.asset('assets/image.jpeg'),
            ),
            // ClipPath
            // 독특한 모양을 커스텀으로 만들고 싶다면 ClipPath 를 사용
            ClipPath(
              child: Image.asset('assets/image.jpeg'),
              clipper: MyCustomClipper(),
            ),
            // 라이브러리 사용
            ClipPath(
              clipper: StarClipper(8),
              child: Container(
                height: 450,
                color: Colors.indigo,
                child: Center(child: Image.asset('assets/image.jpeg')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// getClip 과 shouldReclip 은 반드시 구현해야함
class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path(); // Path 객체 생성
    path.moveTo(0, 0); // 선을 어디서 부터 그을건지.
    path.lineTo(size.width, 0.0); // 선긋기
    path.lineTo(size.width, size.height); // 선긋기
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    // 바로 핫 리로드 반영이 될것인지
    return true;
  }
}

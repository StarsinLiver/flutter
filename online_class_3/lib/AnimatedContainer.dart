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

class _HomeState extends State<_Home> {
  var size; // Size 객체
  bool isOpen = false;


  @override
  Widget build(BuildContext context) {
    // 해당 디바이스의 화면 비율
    size = MediaQuery.of(context).size;
    print("size.width : ${size.width}");

    return buildScaffold();
  }

  // Drawer 를 활용한 예쩨 사이드바는 이걸로 대체 가능
  Scaffold buildScaffoldDrawer() {
    return Scaffold(
    appBar: AppBar(
      title: Text("사이드바 예제 Drawer"),
    ),
    // 쉽게 가능
    endDrawer: Drawer(
      child: Container (
        width: 200,
        height: double.infinity,
        color: Colors.blue,
      ),
    ),
  );
  }

  // 애니메이션 효과 1번 예제
  Scaffold buildScaffold() {
    return Scaffold(
    appBar: AppBar(
      actions: [
        InkWell(
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
            child: Icon(Icons.menu),),
      ],
    ),
    body: Stack(
      children: [
        Center(
          child: Text("Animation Screen"),
        ),
        AnimatedContainer(
          curve: Curves.easeInOut, // 애니메이션 효과
          duration: Duration(seconds: 1), // 시간
          height: double.infinity, // 컨테이너 높이
          width: size.width * (2 / 3), // 컨테이너 넓이
          color: Colors.blue, // 컨테이너 색깔
          // X , Y , Z 좌표
          transform: Matrix4.translationValues(
            // isOpen 이 true 라면 0
            // isOpen 이 false 라면 size.width
             isOpen ? size.width * (1/ 3) : size.width,0,0
          ),
        ),
      ],
    ),
  );
  }
}

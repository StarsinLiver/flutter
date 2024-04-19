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

class _Home extends StatelessWidget {
  const _Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: buildSingleChildScrollView2(),
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollView2() {
    return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              color: Colors.green,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 100,
                itemBuilder: (context, index) => Text("메뉴1"),
              ),
            ),
            Column(
              children: List.generate(
                100,
                    (index) => Text("메뉴 2"),
              ),
            ),
          ],
        ),
      );
  }

  // 1번
  SingleChildScrollView buildSingleChildScrollView1() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // 가로로 리스트를 뿌림
      child: Row(
        children: [
          Menu(),
          SizedBox(width: 15),
          Menu(),
          SizedBox(width: 15),
          Menu(),
          SizedBox(width: 15),
          Menu(),
          SizedBox(width: 15),
          Menu(),
          SizedBox(width: 15),
        ],
      ),
    );
  }
}

// 1번 메뉴
class Menu extends StatelessWidget {
  const Menu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
          minWidth: 100, minHeight: 50, maxWidth: 100, maxHeight: 50),
      color: Colors.orange,
      child: Text("메뉴 1"),
    );
  }
}

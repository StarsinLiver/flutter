import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
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
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/image.jpg',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 0.0,
                sigmaY: 0.0,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/image2.jpg',
                        width: 250,
                        height: 300,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Slider(
                    value: _value,
                    onChanged: (value) {
                      print("value : $_value");
                      setState(() {
                        _value = value;
                      });
                    },
                    activeColor: Colors.deepOrange,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildSubMenu(Icons.add_circle_outline, '보관하기'),
                      buildSubMenu(Icons.play_circle_outline, '플레이'),
                      buildSubMenu(Icons.save_alt_outlined, '저장하기'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "곡 설명",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "안녕! 클로버의 노래, 봄바람처럼 행복과 사랑을 노래하며 작은 잎사귀처럼 행운을 안겨줄 거야. 감미로운 멜로디로 우리 마음을 따스하게 만들며 모든 사랑을 노래해 행복한 봄날을 만들어가자.",
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        children: [
                          buildCard('한국어'),
                          buildCard('중국어'),
                          buildCard('일본어'),
                          buildCard('영어'),
                          buildCard('프랑스어'),
                          buildCard('독일어'),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card buildCard(String mTitle) {
    return Card(
      color: Colors.black45,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.near_me),
            Text(mTitle),
          ],
        ),
      ),
    );
  }

  Column buildSubMenu(IconData icon, String title) {
    return Column(
      children: [
        Icon(
          icon,
          size: 60,
        ),
        Text(title),
      ],
    );
  }
}

import 'package:flutter/material.dart';

// 1. material.dart 수입하기
// 2. main --> runApp() <-- 무조건 호출 (루트 위젯으로 만들어 준다.)
void main() {
  runApp(const MyApp());
}

// 처음부터 위젯을 개발하는 것은 힘들다 --> 상속, 구현 받아서 코드를 작성한다.
// StatelessWidget , StatefulWidget 두가지 중 하나를 선택 해야한다.

// 단축키 - stless
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // build() 메서드가 호출되면 화면을 그려주는 녀석이다.
  @override
  Widget build(BuildContext context) {
    print('build() 메서드 호출 확인');
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // 디버깅 체킹 해제
      home: StorePage(),
    );
  }
} // end of MyApp

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold 는 시작적 레이아웃 구조를 만들어 주는 위젯이다.
    // 위젯은 부모가 될 수 있는 위젯과 자식만 될수 있는 위젯이 있다.
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 1번 자식
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Text(
                    'Woman',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Spacer(), // 남은 공간을 다 차지 하라는 위젯
                  Text(
                    'Kids',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Spacer(), // 남은 공간을 다 차지 하라는 위젯
                  Text(
                    'Shoes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Spacer(), // 남은 공간을 다 차지 하라는 위젯
                  Text(
                    'Bags',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 1,
              child: Image.asset(
                "assets/bag.jpeg",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Expanded(
              flex: 1,
              child: Image.asset(
                "assets/cloth.jpeg",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
} // end of StorePage

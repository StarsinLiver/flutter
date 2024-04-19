import 'package:flutter/material.dart';
import 'package:online_class_3/screens/bottom_navii_page.dart';

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
      child: BottomNavigationBarPage(),
    );
  }
}

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  State<BottomNavigationBarPage> createState() => _HomePageState();
}

class _HomePageState extends State<BottomNavigationBarPage> {
  var _selecttedindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack
      body: IndexedStack(
        index: _selecttedindex,
        children: [
          BottomNaviPage1(),
          BottomNaviPage2(),
          BottomNaviPage3(),
          BottomNaviPage4(),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      // BottomNavigationBar 위젯은 3개 한정이므로
      // 4개 이상 추가하려면 type 을 fixed 로 교체한다.
      type: BottomNavigationBarType.fixed,
      currentIndex: _selecttedindex, // 선택 효과 인덱스
      onTap: (index) {
        setState(() {
          _selecttedindex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: "school",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: "business",
        ),
        // 3개로 제한된 위젯이므로 추가시 fix 위젯을 사용해야 한다.
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "search",
        ),
      ],
    );
  }
}

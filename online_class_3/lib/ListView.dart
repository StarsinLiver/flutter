import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _ListViewHome(),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home({super.key});

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  @override
  Widget build(BuildContext context) {
    // MediaQuery 란?
    // 간략히 , 디바이스의 크기를 알려준다.
    var m = MediaQuery.of(context);
    var safeAreaHeight = m.padding.top;
    print("넓이 : ${m.size.width}");
    print("높이 : ${m.size.height}");
    print("safeArea : ${m.padding.top}");

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.blue,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListViewHome extends StatelessWidget {
  const _ListViewHome({super.key});

  @override
  Widget build(BuildContext context) {
    final colorCodes = [600 , 500 , 400 , 300 , 200];
    final data = ['가','나','다','라','마'];
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context , int index) {
            return buildColumn(colorCodes, index, data);
          },
        ),
      ),
    );
  }

  ListTile buildColumn(List<int> colorCodes, int index, List<String> data) {
    return ListTile(
      title: Text("제목"),
      subtitle: Text("부제목"),
      leading: Icon(Icons.accessibility_sharp),
      onTap: () {
        print("눌러짐 $index");

      },
    );
  }
}

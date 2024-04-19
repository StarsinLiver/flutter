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
        body: Text("안녕"),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true, // 스크롤 기능
              context: context, // 현재 컨텍스트
              builder: (context) => _buildContainer(context),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContainer(BuildContext context) {
    // inset : 삽입이란 뜻이다.
    // 쉽게 말해 가려진 크기 [현재는 텍스트창] 이다.
    print("inset : ${MediaQuery.of(context).viewInsets.bottom}");
    print("padding : ${MediaQuery.of(context).viewPadding.bottom}");

    var bottom = MediaQuery.of(context).viewInsets.bottom;
    return BottomSheet(
      onClosing: () => print("닫아짐"),
      builder: (context) => Container(
        // 키보드 높이에 따라 padding 값을 추가
        padding: EdgeInsets.only(bottom: bottom),
        color: Colors.yellow,
        // 텍스트 창
        child: Container(
          color: Colors.red,
          height: 200, // 전체 크기
          child: TextField(),
        ),
      ),
    );
  }
}

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
  var isLoading = true;
  // CircularProgressIndicator
  // 네트워크로 뭔가를 다운로드 할 때 사용

  // initState 란?
  // 제일 최초에 실행되는 것
  @override
  void initState() {

    super.initState();
    print("initState");
    // [화면은 이미 구성됨]
    // 딜레이 시키기
    Future.delayed(Duration(seconds: 3), () {
      // 네트워크 다운로드 시간 3초
      print("다운로드 완료");
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: isLoading ? CircularProgressIndicator(
            backgroundColor: Colors.red,
            strokeWidth: 1, // 굵기
          ) : Text("다운로드 완료되었습니다."),
        ),
      ),
    );
  }
}

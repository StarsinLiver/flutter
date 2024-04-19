import 'package:flutter/material.dart';
import 'package:online_class_3/screens/home_page.dart';
import 'package:online_class_3/screens/sub_page.dart';

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
        appBar: AppBar(
          title: Text("앱 바 제목"),
        ),
        body: HomePage(),
      ),
    );
  }
}

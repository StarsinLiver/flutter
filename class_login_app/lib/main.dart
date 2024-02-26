import 'package:class_login_app/pages/home_page.dart';
import 'package:class_login_app/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 초기 경로 지정
      initialRoute: '/login',
      // routes : {} 는 Map 구조이다.
      // '/login' : key
      // () => {} : 익명함수가 들어가야 한다. (익명함수는 {}와 return 등 생략이 가능하다
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
      },
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                minimumSize: Size(400, 60))),
      ),
    );
  }
}

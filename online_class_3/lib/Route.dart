import 'package:flutter/material.dart';
import 'package:online_class_3/screens/route_feed.dart';
import 'package:online_class_3/screens/route_home_page.dart';
import 'package:online_class_3/screens/route_sub_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/home", // 최초 화면 지정
      routes: {
        "/home" : (context) => RouteHomePage(),
        "/sub" : (context) => RouteSubPage(),
        "/feed" : (context) => RouteFeedPage(),
      },
    );
  }
}

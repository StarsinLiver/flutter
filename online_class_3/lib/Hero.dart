import 'package:flutter/material.dart';
import 'package:online_class_3/screens/hero_sub_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _Home(), routes: {
      "/sub": (context) => const HeroSubPage(),
    });
  }
}

class _Home extends StatelessWidget {
  const _Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Hero(
              tag: "banner",
              child: Image.asset("assets/image.jpeg"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/sub");
              },
              child: Text("이동"),
            ),
          ],
        ),
      ),
    );
  }
}

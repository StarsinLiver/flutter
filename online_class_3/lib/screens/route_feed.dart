import 'package:flutter/material.dart';
import 'package:online_class_3/screens/sub_page.dart';

class RouteFeedPage extends StatelessWidget {
  const RouteFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feed 페이지입니다."),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.orange,
        child: ElevatedButton(
          child: Text("홈로 이동"),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
          },
        ),
      ),
    );
  }
}

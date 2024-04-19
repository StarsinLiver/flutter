import 'package:flutter/material.dart';
import 'package:online_class_3/Model/user.dart';
import 'package:online_class_3/screens/route_sub_page.dart';
import 'package:online_class_3/screens/sub_page.dart';

class RouteHomePage extends StatelessWidget {
  const RouteHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        child: ElevatedButton(
          child: Text("서브로 이동"),
          onPressed: () {
            Navigator.pushNamed(context, "/sub" , arguments: User(username: "이름"  , password: "패스워드"));
          },
        ),
      ),
    );
  }
}


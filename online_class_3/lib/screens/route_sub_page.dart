import 'package:flutter/material.dart';
import 'package:online_class_3/Model/user.dart';

class RouteSubPage extends StatelessWidget {
  const RouteSubPage({super.key});

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)?.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub 페이지입니다."),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.red,
            child: ElevatedButton(
              child: Text("feed으로 이동"),
              onPressed: () {
                Navigator.pushNamed(context, "/feed");
              },
            ),
          ),
          const SizedBox() ,
          Text("받은 데이터 : ${user.username}"),
          Text("받은 데이터 : ${user.password}"),
        ],
      ),
    );
  }
}

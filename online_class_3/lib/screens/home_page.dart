import 'package:flutter/material.dart';
import 'package:online_class_3/screens/sub_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        child: ElevatedButton(
          child: Text("서브로 이동"),
          onPressed: () {
            // pushNamed
              Navigator.pushNamed(context, "/sub");
          },
        ),
      ),
    );
  }
}

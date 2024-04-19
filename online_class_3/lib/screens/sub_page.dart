import 'package:flutter/material.dart';

class SubPage extends StatelessWidget {
  const SubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("앱 바 제목"),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.red,
        child: ElevatedButton(
          child: Text("홈으로 이동"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

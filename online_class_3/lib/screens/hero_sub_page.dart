import 'package:flutter/material.dart';

class HeroSubPage extends StatelessWidget {
  const HeroSubPage({Key? key}) : super(key: key); // 수정

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub 페이지입니다."),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.red,
            height: 400,
            child: ElevatedButton(
              child: Text("홈으로 이동"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Hero(
            tag: "banner",
            child: Image.asset("assets/image.jpeg"),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// 텍스트를 외부에서 값을 받아서 설계
class Logo extends StatelessWidget {
  final String title;

  const Logo(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 이미지
        SvgPicture.asset(
          "assets/logo.svg",
          height: 70,
          width: 70,
        ),
        // 텍스트
        Text(
          title,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

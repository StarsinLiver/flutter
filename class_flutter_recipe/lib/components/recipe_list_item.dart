import 'package:flutter/material.dart';

class RecipeListItem extends StatelessWidget {
  final String imageName;
  final String title;

  // 생성자
  // dart 는 오버로딩이 없다.
  const RecipeListItem(
      {required this.imageName, required this.title, super.key});

  // build 함수가 호출 되면 화면에 그림을 그려준다.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 2 / 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/${imageName}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          Text("Have you ever made your own $title?"
              "Once you've tried a homemade $title, "
              "you'll nevergo back.")
        ],
      ),
    );
  }
}

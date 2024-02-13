import 'package:class_flutter_recipe/components/recipe_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 1. 페이지 기본 코딩
class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildRecipeAppBar(),
      body: RecipeTitle(),
    );
  }
}

// 전역 함수
AppBar _buildRecipeAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1.0, // AppBar 의 그림자 효과를 조정할 수 있음
    actions: [
      Icon(CupertinoIcons.search, color: Colors.black),
      SizedBox(width: 15),
      Icon(CupertinoIcons.heart, color: Colors.redAccent),
      SizedBox(width: 15),
    ],
  );
} // end of AppBar

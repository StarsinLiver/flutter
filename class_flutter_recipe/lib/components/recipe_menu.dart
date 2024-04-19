import 'package:flutter/material.dart';

class RecipeMenu extends StatelessWidget {
  const RecipeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          _buildMenuItem(Icons.food_bank, "ALL"),
          const SizedBox(
            width: 25,
          ),
          _buildMenuItem(Icons.emoji_food_beverage, "Coffe"),
          const SizedBox(
            width: 25,
          ),
          _buildMenuItem(Icons.fastfood, "Burget"),
          const SizedBox(
            width: 25,
          ),
          _buildMenuItem(Icons.local_pizza, "Piza"),
          const SizedBox(
            width: 25,
          ),
        ],
      ),
    );
  }

  // 커스텀한 위젯을 만들어야 할 때 컨테이너 위젯을 사용
  // 꾸며 주는 속성이 존재한다. (decoration)
  Widget _buildMenuItem(IconData mIcon, String text) {
    return Container(
      width: 60,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black12)),
      // Column 에는 주축 방향, 교차축 방향  이 있다.
      // Row 에는 주축 방향, 교차축 방향 이 있다.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(mIcon), const SizedBox(width: 30), Text(text)],
      ),
    );
  }
}

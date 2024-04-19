import 'package:flutter/material.dart';

class OptionListPage extends StatelessWidget {
  const OptionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Home(),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home({super.key});

  @override
  Widget build(BuildContext context) {
    final colorCodes = [600, 500, 400, 300, 200];
    final data = ['가', '나', '다', '라', '마'];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: [
          //1번
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "이름",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "정보",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: 100,
                  child: Image.asset(
                    "assets/background.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          // 리스트
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return buildColumn(colorCodes, index, data);
              },
            ),
          ),
        ],
      ),
    );
  }
}

ListTile buildColumn(List<int> colorCodes, int index, List<String> data) {
  return ListTile(
    title: Text("제목"),
    subtitle: Text("부제목"),
    trailing: Icon(Icons.account_balance),
    onTap: () {
      print("눌러짐 $index");
    },
  );
}

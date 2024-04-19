import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _Home(),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home({super.key});

  @override
  State<_Home> createState() => _HomeState();
}

class Item {
  int id;
  bool isState;

  Item(this.id, this.isState);
}

class _HomeState extends State<_Home> {
  var data = [
    Item(1, false),
    Item(2, false),
    Item(3, false),
    Item(4, false),
    Item(5, false),
    Item(6, false),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // ExpantionPanelList 는 제한이 없으므로 오류가 나옴
        // 따라서 SingleChildScrollView로 감싸야함
        body: SingleChildScrollView(
          // 확장 List 형식
          child: ExpansionPanelList(
            children: List.generate(
              data.length,
              (index) => buildExpansionPanel(data[index]),
            ),
          ),
        ),
      ),
    );
  }

  ExpansionPanel buildExpansionPanel(Item item) {
    return ExpansionPanel(
      isExpanded: item.isState, // 확장 : true , 미확장  : false
      // build 되었을 때
      headerBuilder: (context, isExpanded) {
        return Dismissible(
          key: UniqueKey(), // 배열요소 (수정,삭제,추가)
          onDismissed: (direction) {
            print("item id : ${item.id}"); // 해당 값 삭제
            // where 함수 : 값을 걸러내서 return 을 해줌 그것을 새로운 배열에 담을 수 있음
            // removeWhere함수 : 실제 값을 수정함.
            setState(() {
              data.removeWhere((element) => element.id == item.id);
            });
          },
          child: ListTile(
            title: Text("item Child : ${item.id} 번"),
            onTap: () {
              // 스테이트변경
              setState(() {
                item.isState = !isExpanded;
              });
            },
          ),
        );
      },
      body: ListTile(
        title: Text("item Child"),
      ),
    );
  }
}

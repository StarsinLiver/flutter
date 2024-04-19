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

class _Home extends StatelessWidget {
  const _Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Card(
          child: InkWell(
            onTap: () {
              print("클릭됨");
            },
            splashColor: Colors.blue,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.album),
                  title: Text("The Enchanted Nightingale"),
                  subtitle: Text("저걸 어떻게 써 시뎅"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end
                  ,
                  children: [
                    Text('BUY TICKETS'),
                    Text('LISTEN'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

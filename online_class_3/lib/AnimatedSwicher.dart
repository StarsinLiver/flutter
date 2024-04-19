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

class _HomeState extends State<_Home> {
  // dynamic 어떤 타입이 들어와도 상관없슴
  dynamic mWidget = FirstWidget();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            AnimatedSwitcher(
              duration: Duration(seconds: 3),
              child: mWidget,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  mWidget = mWidget.runtimeType == FirstWidget
                      ? SecondWidget()
                      : FirstWidget();
                });
              },
              child: Text("버튼"),
            ),
          ]),
        ),
      ),
    );
  }
}

class FirstWidget extends StatelessWidget {
  const FirstWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: 100,
      height: 100,
    );
  }
}

class SecondWidget extends StatelessWidget {
  const SecondWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      width: 300,
      height: 300,
    );
  }
}

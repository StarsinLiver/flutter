import 'package:flutter/material.dart';

class DrawerSub extends StatelessWidget {
  const DrawerSub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sub"),
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}

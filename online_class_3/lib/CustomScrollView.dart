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
    
    // 앱 바의 높이
    // collapseHeight 최소값은 56.0 보다는 커야함
    // const double kToolbarHeight = 56.0;
    var height = AppBar().preferredSize.height;
    print("앱바의 높이 : $height");

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("제목"),
              expandedHeight: 300, // appbar 의 높이가 늘어남
              collapsedHeight: 100, // toolbarHeight 56.0 보다 커야함
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                // 자식 수를 지정
                childCount: 100,
                // IndexedWidgetBuilder
                (context, index) => Text("dsadsad"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:online_class_3/screens/drawer_sub.dart';

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
        appBar: AppBar(
          title: Text("Drawable"),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  "제목",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.album),
                title: Text("앨범"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DrawerSub() ,),);
                },
              ),
              ListTile(
                leading: Icon(Icons.album),
                title: Text("앨범"),
              ),
            ],
          ),
        ),
        body: Text("이동"),
      ),
    );
  }
}

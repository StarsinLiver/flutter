import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:room_me/home.dart';
import 'package:room_me/login.dart';
import 'package:room_me/product_detail.dart';
import 'package:room_me/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _Home(),
      // 라우팅
      routes: {
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/home": (context) => HomePage(),
        "/product-detail": (context) => ProductDetail(),
      },

    );
  }
}

class _Home extends StatelessWidget {
  const _Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [
              Image.asset(
                "assets/background.jpeg",
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 0.0,
                  sigmaY: 0.0,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          "assets/icon.png",
                          height: 80,
                          width: 80,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Roome",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 50,
                        ),
                      ),
                      Text(
                        "소제목",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/home");
                        },
                        child: Text("홈 화면"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                          backgroundColor: Colors.cyanAccent,
                        ),
                      ),
                      SizedBox(height: 10,),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        child: Text("로그인"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                          backgroundColor: Colors.cyanAccent,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          // 라우팅
                          Navigator.pushNamed(context, "/register");
                        },
                        child: Text(
                          "회원가입",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

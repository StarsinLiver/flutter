import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: const _Register(),
    );
  }
}

class _Register extends StatelessWidget {
  const _Register({super.key});



  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: media.height,
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // 일반 회원 또는 로그인
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildElevatedButton(Icons.facebook, 'Facebook', Colors.indigo),
                  SizedBox(width: 8),
                  buildElevatedButton(
                      Icons.tiktok, 'Ticktok', Colors.lightBlueAccent),
                ],
              ),
              SizedBox(height: 10),
              Text("밑 소제목"),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: "type your ADDRESS",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: "type your PHONE NUMBER",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              ),
      
              SizedBox(height: 10),TextField(
                decoration: InputDecoration(
                  hintText: "type your ID",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  hintText: "type your PASSWORD",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                onPressed: () {},
                child: Text("Sign In"),
              ),
              SizedBox(height: 20,),
              Text("해당 위의 정보가 사실임을 입증합니다."),
              Spacer(),
              Text("already have your account? Click here!!"),
            ],
          ),
        ),
      ),
    );
  }

  // 버튼
  Expanded buildElevatedButton(
      IconData icon, String title, Color backgroundColor) {
    return Expanded(
      child: FilledButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

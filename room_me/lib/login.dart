import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(child: _SignIn()),
    );
  }
}

class _SignIn extends StatelessWidget {
  const _SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      height: media.height * (6 / 7),
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Log In",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 10),
            Align(
                alignment: Alignment.centerRight,
                child: Text("forgot your PASSWORD?")),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              onPressed: () {},
              child: Text("Log In"),
            ),
            Spacer(),
            Text("forgot your ID? Click here!!"),
          ],
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

import 'package:class_login_app/components/custom_form.dart';
import 'package:class_login_app/components/logo.dart';
import 'package:class_login_app/size.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Scaffold(
          body: ListView(
        children: [
          // logo 위젯 생성
          const SizedBox(height: xlarge_gap),
          const Logo('Login'),
          const SizedBox(height: large_gap),
          CustomForm(),
        ],
      )),
    ));
  }
}

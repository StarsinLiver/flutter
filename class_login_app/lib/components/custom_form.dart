import 'package:class_login_app/components/custom_text_form_field.dart';
import 'package:class_login_app/size.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>(); // 1. 글로벌 Key
  CustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        // 글로벌 key 를 Form  태그에 연결하여 해당 Key 로 Form 의 상태를 관리할 수 있음
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField('Email'),
            SizedBox(
              height: medium_gap,
            ),
            CustomTextFormField('Password'),
            SizedBox(
              height: large_gap,
            ),
            TextButton(
                onPressed: () {
                  // 사용자가 입력한 유효성 검사
                  if (_formKey.currentState!.validate()) {
                    // 즉, 오류가 없다면 화면 이동 처리
                    Navigator.pushNamed(context, "/home");
                  }
                },
                child: Text('Login'))
          ],
        ));
  }
}

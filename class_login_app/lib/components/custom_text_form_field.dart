import 'package:class_login_app/size.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;

  const CustomTextFormField(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        SizedBox(
          height: small_gap,
        ),
        TextFormField(
          // validator : 이벤트 핸들러
          // ! 는 null이 절대 아니다라는 것을 컴파일러에게 알려줍니다.
          validator: (value) =>
              value!.isEmpty ? "Please enter some text" : null,
          // 해당 TextFormField 가 비밀번호 양식이면 **** 처리 해주기
          obscureText: text == "Password" ? true : false,
          // 데코레이션
          decoration: InputDecoration(
            hintText: 'Enter $text',
            // 첫 화면시 기본 FormField 디자인
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            // 손가락 터치시 ... 디자인
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            // 애러 발생시 ... 디자인
            errorBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            // 에러 발생 후 손가락 터치시 ... 디자인
            focusedErrorBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          ),
        )
      ],
    );
  }
}

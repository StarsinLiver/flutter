import 'package:flutter/material.dart';

// 코드의 시작점
void main() {
  // Dog d1 = new Dog(); (객체 생성 메모리에 로드 - new 생략 가능)
  // Dog d1 = Dog('toto', 10, 'white', 100); // 메모리에 로드 객체 생성
  Dog d1 = Dog(age: 10, color: 'white', thirsty: 100, name: 'toto');
} // end of main

class Dog {
  String? name;
  int? age;
  String? color;
  int? thirsty;

//   메서드 , 함수 , 생성 --> 파라미터 설계 (단일 라인 생성자 - 생략했었음)
// 파라미터 --> 선택적 매개 변수
// 함수({}); -> 중괄호로 감싸면 된다.
//   required --> 반드시 해당 매개변수를 써야한다라고 명시.
  Dog(
      {required this.name,
      required this.age,
      required this.color,
      required this.thirsty});
}

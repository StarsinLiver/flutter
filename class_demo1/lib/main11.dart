void main() {
  List<String> footballPlayers = ['메시', '손흥민', '김민재', '조규성'];
//   1단계. 자료구조와 익명함수
//  2단계 dart List는 Iterable 을 구현하고 있다.
//  리스트는 반복 가능한 객체 이다라고 말할 수 있다.

  footballPlayers.forEach((e) {
    print("축구선수 : ${e}");
  });

  footballPlayers.forEach((e) => print("축구선수 : ${e}"));

  //   문제 forEach 문을 활용해서 list 안의 요소들에 덧셈값을 연산하고 출력하시오.
  List<int> numbers = [10, 20, 30, 40, 50];
  int sum1 = 0; // 익명 함수 사용
  int sum2 = 0; // 화살표 함수 사용

//   1. 익명 함수 사용
  numbers.forEach((e) {
    sum2 += e;
  });
//   2. 람다 표현식 사용
  numbers.forEach((e) => sum2 += e);
}

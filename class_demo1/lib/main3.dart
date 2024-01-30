void main() {
//   논리 연산자 (부정 , 그리고 , 또는)
  // 부정
  print(!true);

  // 그리고
  print(true && false);

  // 또는
  print(false || true);

//   AND -> 빠른 평가를 만들어 보자
  print(false && true); // 뒤에는 연산할 필요가 없음

//   OR -> 빠른 평가를 만들어 보자
  print(true || true);

  var n1 = 0;
  var n2 = 10;
  print((n1 = 100) > 50 || (n2 = 200) < 100);
  print("현재 시점에 n1에 값은 ${n1}");
  print("현재 시점에 n2에 값은 ${n2}");

  

}

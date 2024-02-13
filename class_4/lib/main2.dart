void main() {
//   반복문
  var list = [1, 2, 3, 4];
  for (int i = 0; i < list.length; i++) {
    print(list[i]);
  }

  // list --> map() 함수가 있다.
  // map -> 반복되는 값을 하나씩 변형하기 위해 사용합니다.
  var chobab = ['새우초밥', '광어초밥', '연어초밥'];
  var chobabChange = chobab.map((i) => "간장 " + i);
  print(chobabChange);
  print(chobabChange.runtimeType);
  print(chobabChange.toList());

  //where 연산자
  // 반복되는 값에서 필요없는 값을 필터링 하거나 , 필요한 값을 찾을 때 사용합니다.
  var chobabChange2 = chobab.where((i) => i != '광어초밥');
  print(chobabChange2.runtimeType);
  print(chobabChange2.toList());
}

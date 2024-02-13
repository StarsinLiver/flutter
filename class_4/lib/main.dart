import 'dart:math'; // 다트에서 기본적으로 제공하는 라이브러리를 import 합니다.

void main() {
  List<int> nums = [1, 2, 3, 4, 5];
  print(nums[0]);
  print(nums[1]);
  print(nums[2]);
  print(nums[3]);
  print(nums[4]);

  // map 리터럴은 중괄호이다.
  Map<String, dynamic> user = {
    'id': 1,
    'username': 'cos',
  };

  // key 연산은 인덱스 연산자를 활용합니다.
  print(user['id']);
  print(user['username']);

  // set 리터럴은 중괄호를 사용합니다.
  Set<int> lotto = {};
  Random r = Random();

  while (lotto.length < 6) {
    lotto.add(r.nextInt(45) + 1); // 1 ~ 45
  }

  List<int> lottoList = lotto.toList();
  print(lottoList);
}

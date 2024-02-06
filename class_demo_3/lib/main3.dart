class Burger {
  String? name;
  Burger(this.name);
}

// 이니셜라이저 [[ : ]]
class CheezeBurger extends Burger {
  CheezeBurger(String name) : super(name); // 이니셜라이져 키워드
}

void main() {
  CheezeBurger burger = CheezeBurger('마이 치즈버거'); // 다형성 적용
  print(burger.name);
}

class Burger {
  Burger() {
    print("버거");
  }
}

class CheezeBurger extends Burger {
  CheezeBurger() {
    print('치즈버거');
  }
}

void main() {
  CheezeBurger cheezeBurger = CheezeBurger();
  Burger burger = CheezeBurger(); // 다형성 적용
}

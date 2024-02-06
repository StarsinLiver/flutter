class Dog {
  void sound() {
    print('멍멍 배고파');
  }
}

class Cat {
  void sound() {
    print('야옹 배고파');
  }
}

class Fish {
  void hungry() {
    print('뻐끔뻐끔 배고파');
  }
}

void main() {
  Dog dog = Dog();
  Cat cat = Cat();
  Fish fish = Fish();

  dog.sound();
  cat.sound();
  // fish.sound(); // 오류
}

abstract class Animal {
  void sound();
}

class Dog implements Animal {
  void sound() {
    print('멍멍 배고파');
  }
}

class Cat implements Animal {
  void sound() {
    print('야옹 배고파');
  }
}

class Fish implements Animal {
  @override
  void sound() {
    print('뻐끔뻐금 배고파');
  }
}

void main() {
  Dog dog = Dog();
  Cat cat = Cat();
  Fish fish = Fish();

  dog.sound();
  cat.sound();
  fish.sound();
}

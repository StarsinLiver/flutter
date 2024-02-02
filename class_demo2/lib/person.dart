class Person {
  String? name;
  int money;

  Person({this.name, this.money = 0});
}

void main() {
  Person p1 = Person(name: '홍길동');
  Person p2 = Person(name: '티모', money: 1000);
}

class A {
  var key;

  A({this.key}) {
    print('A 생성');
    print(key);
  }
}

class B extends A {

  // 내부 super(key) 를 사용하지 못하는 이유
  // A 객체가 B 보다 먼저 생성 되기 때문!! 한마디로 super(key)를 무시하고 먼저 A 객체를 생성
  // 따라서 이니셜라이저를 사용해야만 key 값을 넘겨 줄수 있음.
  // 자바에서는 super(key) 로써 B 객체 생성 후 A 객체가 생성되지만
  // dart 에서는 또는 flutter 에서는 부모 객체[A]가 먼저 생성됨
  B (var key) : super(key : key) {
    //super(key); // 불가능 -> 이니셜라이저를 사용해야됨
    print("B 생성");
  }
}

void main () {
  var key = "cos";
  B(key); // B 객체 생성
}
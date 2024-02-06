void main() {
  // final <-- 상수 (불변) --> 런타임 상수
  // const <-- 상수 (불변) --> 컴파일 상수
  final myObject = MyClass();
  myObject.pringString();
}

class MyClass {
  late String name;

  MyClass() {
    //   서버에서 요청한 값을 받아서 클래스를 만들어야 될 때
    //   즉, 통신을 통해 초기값을 받아야 하는 경우 사용이 가능하다.
    name = '홍길동';
  }

  void pringString() {
    print('name : ${name}');
  }
}

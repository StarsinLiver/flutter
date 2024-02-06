// 상속 구조 생성 -->
// 부모 클래스 --> 단일 생성자 생성
// 자식 클래스 --> 이니셜 라이져 생성

class Tea {
  String? name;
  int? taste;
  Tea(this.name, this.taste);
}

class BubbleTea extends Tea {
  BubbleTea(String name, int taste) : super(name, taste); // 이니셜라이져 키워드
}

void main() {
  Tea bubbleTea = BubbleTea('버블티네요', 100); // 다형성 적용
  print(bubbleTea.name);
  print(bubbleTea.taste);
}

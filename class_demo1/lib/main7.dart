void main() {
//   1. null 속성 접근 방법 ? , ??
  String? maybeName = "가나다라마바사";
  // null 아니면 문자열 길이를 반환 , null --> 0을 반환
  int resultLength = maybeName?.length ?? 0;
  print(resultLength);

//   2. null 에 안전한 객체 메서드 접근
  String? name = getName(); // null 또는 문자열을 담을 수 있다.
  String? returnName = name?.toLowerCase() ?? "홍길동";
  print(returnName);
}

// 전역함수
String? getName() {
  return null;
}

void main() {
  int point = 90;
  if (point >= 90) {
    print('A학점');
  } else if (point >= 80) {
    print('B학점');
  } else if (point >= 70) {
    print('C학점');
  } else {
    print('F학점');
  }


//   삼항연산자
//  조건식? 결과 1 : 결과 2
  print(point >= 60? '합격' : '불합격');

  switch (point) {
    case 60 :
      print('안녕');
      break;
    case 90:
      print('뭔데');
      break;
  }

}
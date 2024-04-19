import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: _Home(),
      ),
    );
  }
}

class _Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 디바이스의 현재 크기
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Friday, February 21",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Go to the vacation",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search Anything..",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.blue,
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: AspectRatio(
                  aspectRatio: 1.5 / 1,
                  child: Image.asset(fit: BoxFit.cover, 'assets/image.jpeg'),
                ),
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Category",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildCategory('assets/image.jpeg', 'Camping'),
                    SizedBox(
                      width: 20,
                    ),
                    buildCategory('assets/image.jpeg', 'Vacation'),
                    SizedBox(
                      width: 20,
                    ),
                    buildCategory('assets/image.jpeg', 'Camping'),
                    SizedBox(
                      width: 20,
                    ),
                    buildCategory('assets/image.jpeg', 'Vacation'),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: "화살표",
            icon: Icon(Icons.near_me),
          ),
          BottomNavigationBarItem(
            label: "좋아요",
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: "카트",
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
    );
  }

  // 이미지 카테고리
  Widget buildCategory(String imageUrl , String title) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1 / 0.5,
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(imageUrl)),
            ),
            SizedBox(
              height: 10,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

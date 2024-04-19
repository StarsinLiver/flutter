import 'package:flutter/material.dart';

// Swiper
import 'package:card_swiper/card_swiper.dart';
import 'package:room_me/option_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IndexedStack(
          index: _selectedIndex,
          children: [
            OptionListPage(),
            _Home(),
            OptionListPage(),
          ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              label: "티켓", icon: Icon(Icons.airplane_ticket)),
          BottomNavigationBarItem(
              label: "홈", icon: Icon(Icons.airplane_ticket)),
          BottomNavigationBarItem(
              label: "내정보", icon: Icon(Icons.airplane_ticket)),
        ],
      ),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    var images = [
      'assets/background.jpeg',
      'assets/background.jpeg',
      'assets/background.jpeg',
    ];
    return ListView(
      children: [
        Column(
          children: [
            Container(
              height: media.height * (2 / 3),
              child: Stack(
                children: [
                  // 슬라이더
                  Swiper(
                    itemBuilder: (context, index) {
                      final image = images[index];
                      return buildSwiperChild(image, media);
                    },
                    indicatorLayout: PageIndicatorLayout.COLOR,
                    autoplay: true,
                    itemCount: images.length,
                    pagination: const SwiperPagination(),
                    control: const SwiperControl(),
                  ),
                  // 검색창
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          hintText: "Search Anything..",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 메인 부분
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "foreign travel",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: InkWell(
                            onTap: () {
                              // 페이지 이동
                              Navigator.of(context).pushNamed("/product-detail",
                                  arguments: index);
                            },
                            child: Stack(
                              children: [
                                Image.asset(
                                  "assets/background.jpeg",
                                  fit: BoxFit.fill,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    maxLines: 1,
                                    "ㅎㅇ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 스와이퍼 이미지 , 제목 , 보러가기
  Stack buildSwiperChild(String image, Size media) {
    return Stack(
      children: [
        Image.asset(
          image,
          fit: BoxFit.fill,
          height: media.height * (2 / 3),
        ),
        // 이미지 설명
        Padding(
          padding: EdgeInsets.only(
              right: media.width * (1 / 3), left: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cape Town 이미지 제목",
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "이미지 설명",
                maxLines: 2,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                child: Text("보러 가기"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

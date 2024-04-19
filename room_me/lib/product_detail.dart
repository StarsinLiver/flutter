import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(),
      body: _Home(),
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

    return SingleChildScrollView(
      child: Column(
        children: [
          // 메인 이미지
          Container(
            height: media.height * (1 / 4),
            child: Swiper(
              itemBuilder: (context, index) {
                final image = images[index];
                return Image.asset(
                  'assets/background.jpeg',
                  fit: BoxFit.fill,
                );
              },
              indicatorLayout: PageIndicatorLayout.COLOR,
              autoplay: true,
              itemCount: images.length,
              pagination: const SwiperPagination(),
              control: const SwiperControl(),
            ),
          ),
          // 제목
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: media.width * (2 / 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Grand Royale Park Motel",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                          Text("here is location"),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("\$220"),
                        Text("수수료 있음"),
                      ],
                    ),
                  ],
                ),
                Divider(
                  height: 30,
                  color: Colors.grey,
                  thickness: 2,
                ),
                // 메인 설명
                Text("introduce"),
                Text("메인 설명"),
                SizedBox(
                  height: 20,
                ),
                // 평점
                Row(
                  children: [
                    // 점수
                    Text(
                      "9.2",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 50,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    // 이름 , 별점
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Grand Royale Prak Motel"),
                        Row(
                          children: [
                            Icon(Icons.star),
                            Icon(Icons.star),
                            Icon(Icons.star),
                            Icon(Icons.star_border),
                            Icon(Icons.star_border),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                // 1 ~ 5 점까지
                buildPercentBar('good', 0.2),
                buildPercentBar('middle', 0.5),
                buildPercentBar('bad', 0.3),
                // 줄 긋기
                Divider(
                  height: 40,
                  color: Colors.grey,
                  thickness: 1,
                ),
                // 이미지 , 더보기
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("이미지"),
                    Text("더보기"),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 100,
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
                            Navigator.of(context)
                                .pushNamed("/product-detail", arguments: index);
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
                ),
                // 줄 긋기
                Divider(
                  height: 40,
                  color: Colors.grey,
                  thickness: 1,
                ),
                // 리뷰
                buildReview(),
                buildReview(),
                buildReview(),
                buildReview(),
                // 더보기
                ElevatedButton(
                  onPressed: () {},
                  child: Text("더보기"),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Container(
                      width: 60, child: Image.asset('assets/background.jpeg')),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("텍스트"),
                    Text("텍스트"),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("2024.04.04"),
                Row(
                  children: [
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star_border),
                    Icon(Icons.star_border),
                  ],
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text("댓글"),
        Opacity(
          opacity: 0.2,
          child: Divider(
            height: 40,
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ],
    );
  }

  // 퍼센트 바 (good, middle , bad)
  Padding buildPercentBar(String title, double value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            flex: 8,
            child: LinearProgressIndicator(
              value: value,
              color: Colors.yellow,
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }
}

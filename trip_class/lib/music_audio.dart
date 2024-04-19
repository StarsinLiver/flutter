import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: _Home(),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home({super.key});

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  double _value = 0.0;

  // Declare AudioPlayer variable
  late AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  bool isPlaying = false;
  double volume = 1;

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer.open(
      Audio("assets/HEYYEYAAEYAAAEYAEYAA.m4a"),
      loopMode: LoopMode.single, //반복 여부 (LoopMode.none : 없음)
      autoStart: false, //자동 시작 여부
      showNotification: false, //스마트폰 알림 창에 띄울지 여부
      volume: volume
    );

  }

  // 플레이어 플레이
  void play() async {
    // Instantiate AudioPlayer class
    await _assetsAudioPlayer.play(); //재생
  }

  void pause() async {
    await _assetsAudioPlayer.pause(); //멈춤
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/image.jpg',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 0.0,
                sigmaY: 0.0,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/image2.jpg',
                        width: 250,
                        height: 300,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Slider(
                    value: _value,
                    onChanged: (value) {
                      print("value : $_value");
                      setState(() {
                        _assetsAudioPlayer.currentPosition.listen((positionValue){
                          print("현재 시간 : $positionValue");
                          _value = value;
                        });
                      });
                    },
                    activeColor: Colors.deepOrange,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildSubMenu(Icons.add_circle_outline, '보관하기'),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isPlaying = !isPlaying;
                            isPlaying ? play() : pause();
                          }
                          );
                        },
                        child: buildSubMenu(isPlaying ? Icons.pause_circle_outline : Icons.play_circle_outline, '플레이'),
                      ),
                      buildSubMenu(Icons.save_alt_outlined, '저장하기'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "곡 설명",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "안녕! 클로버의 노래, 봄바람처럼 행복과 사랑을 노래하며 작은 잎사귀처럼 행운을 안겨줄 거야. 감미로운 멜로디로 우리 마음을 따스하게 만들며 모든 사랑을 노래해 행복한 봄날을 만들어가자.",
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        children: [
                          buildCard('한국어'),
                          buildCard('중국어'),
                          buildCard('일본어'),
                          buildCard('영어'),
                          buildCard('프랑스어'),
                          buildCard('독일어'),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card buildCard(String mTitle) {
    return Card(
      color: Colors.black45,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.near_me),
            Text(mTitle),
          ],
        ),
      ),
    );
  }

  Column buildSubMenu(IconData icon, String title) {
    return Column(
      children: [
        Icon(
          icon,
          size: 60,
        ),
        Text(title),
      ],
    );
  }
}

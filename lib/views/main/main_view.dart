
import 'package:common_project/widget/advertisement_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();

  static String get className => 'MainView';
  static String get path => '/main';
}

class _MainViewState extends State<MainView> {
  void _showBottomAd(BuildContext context) {
    final adContent = Container(
      height: 50, // Height of the ad container
      color: Colors.blueAccent,
      child: Center(
        child: Text(
          'This is an Advertisement',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return adContent;
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('텍스트'),
          InkWell(
            child: Text('광고 버튼'),
            onTap: () async {
              String? signatureValue = await showModalBottomSheet<String>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent, // 배경색을 투명하게 설정하여 라운드 처리된 모서리가 보이도록 합니다.
                builder: (BuildContext context) {
                  // MediaQuery를 사용하여 디바이스의 높이를 얻습니다.
                  final screenHeight = MediaQuery.of(context).size.height;
                  return Container(
                    height: screenHeight / 2, // 디바이스 높이의 절반을 높이로 설정
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                    ),
                    child: const AdvertisementWidget(),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}

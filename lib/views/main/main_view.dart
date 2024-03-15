
import 'package:common_project/views/search/search_view.dart';
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
          InkWell(
            child: const Text('광고 위젯'),
            onTap: () {
              showModalBottomSheet<String>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent, // 배경색을 투명하게 설정하여 라운드 처리된 모서리가 보이도록 합니다.
                builder: (BuildContext context) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                    ),
                    child: const AdvertisementWidget(),
                  );
                },
              );
            },
          ),
          InkWell(
            child: const Icon(Icons.search, color: Colors.black),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return FractionallySizedBox(
                    heightFactor: 1.0,
                    child: Container(
                      color: const Color.fromRGBO(248, 248, 248, 1),
                      child: SearchView(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

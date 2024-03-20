
import 'package:flutter/material.dart';

class Page1View extends StatefulWidget {
  const Page1View({super.key});
  static String get path => '/page1';

  @override
  State<Page1View> createState() => _Page1ViewState();
}

class _Page1ViewState extends State<Page1View> with SingleTickerProviderStateMixin {
  // TabController 추가
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 탭 컨트롤러 초기화
    _tabController = TabController(length: 2, vsync: this, animationDuration: Duration.zero, initialIndex: 0);
  }

  @override
  void dispose() {
    // 탭 컨트롤러 정리
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // DefaultTabController로 전체를 감싼다
    return Scaffold(
      appBar: AppBar(
        title: const Text('탭 예제'),
      ),
      // 본문에 Column을 사용하여 TabBar와 TabBarView를 배치
      body: Column(
        children: [
          // 탭바 배치
          Padding(
            padding: const EdgeInsets.all(0),
            child: TabBar(
              controller: _tabController,
              // dividerColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              // indicatorColor: Colors.transparent, // 하단 밑줄 색상
              indicatorColor: Colors.green,
              splashBorderRadius: BorderRadius.circular(40),
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: const TextStyle(fontSize: 20),
              labelStyle: const TextStyle(fontSize: 20),
              labelColor: Colors.black,
              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
              tabs: const [
                Tab(child: Text('탭1')),
                Tab(text: '탭 2'),
              ],
            ),
          ),
          // 탭뷰를 확장하여 나머지 공간을 차지하도록 함
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(), // 스와이프로 탭 내용 변경을 방지
              children: const [
                Center(child: Text('탭 1의 내용')),
                Center(child: Text('탭 2의 내용')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
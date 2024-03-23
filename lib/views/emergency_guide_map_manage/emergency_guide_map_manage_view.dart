
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

class EmergencyGuideMapManageView extends StatefulWidget {
  const EmergencyGuideMapManageView({super.key});
  static String get path => '/emergencyGuideMapManage';
  @override
  State<EmergencyGuideMapManageView> createState() => _EmergencyGuideMapManageViewState();
}

class _EmergencyGuideMapManageViewState extends State<EmergencyGuideMapManageView> {
  // late Future<Uint8List> _future; // 이미지 1장인경우
  late Future<List<Uint8List>> _future;
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // Future<Uint8List> loadImageFromAssets(String path) async {
  //   final byteData = await rootBundle.load(path);
  //   return byteData.buffer.asUint8List();
  // }

  Future<List<Uint8List>> loadImagesFromAssets(List<String> paths) async {
    return Future.wait(paths.map((path) async {
      final byteData = await rootBundle.load(path);
      return byteData.buffer.asUint8List();
    }).toList());
  }


  @override
  void initState() {
    super.initState();
    // _future = loadImageFromAssets('assets/images/image.png');
    _future = loadImagesFromAssets([
      'assets/images/image.png',
      'assets/images/image2.png',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Uint8List>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(
              radius: 20,
              color: Colors.grey,
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('파일을 불러오는데에 실패하였습니다.'));
        } else {
          final images = snapshot.requireData;
          return SizedBox(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: images.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return PhotoView(
                            imageProvider: MemoryImage(images[index]),
                            backgroundDecoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            loadingBuilder: (context, event) => Container(),
                            // maxScale: PhotoViewComputedScale.covered * 5, // 최대 200% 크기
                            initialScale: PhotoViewComputedScale.contained,
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 60,
                        child: Row(
                          children: [
                            InkWell(
                              child: Container(
                                color: const Color.fromRGBO(0, 0, 0, 0.8),
                                constraints: const BoxConstraints.expand(width: 40),
                                child: const Icon(
                                  Icons.keyboard_arrow_left,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeOut,
                                );
                              },
                            ),
                            Expanded(
                              child: Container(
                                color: const Color.fromRGBO(0, 0, 0, 0.8),
                                //color: Colors.white,
                                child: Center(
                                  child: Text(
                                    '${_currentIndex + 1}/${images.length}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                color: const Color.fromRGBO(0, 0, 0, 0.8),
                                constraints: const BoxConstraints.expand(width: 40),
                                child: const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeOut,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
     )
   );
  }
}

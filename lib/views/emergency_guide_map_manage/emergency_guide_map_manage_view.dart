
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class EmergencyGuideMapManageView extends StatefulWidget {
  const EmergencyGuideMapManageView({super.key});
  static String get path => '/emergencyGuideMapManage';
  @override
  State<EmergencyGuideMapManageView> createState() => _EmergencyGuideMapManageViewState();
}

class _EmergencyGuideMapManageViewState extends State<EmergencyGuideMapManageView> {
  late Future<Uint8List> _future;


  @override
  void initState() {
    super.initState();
    _future = Future.delayed(Duration(hours: 1));
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
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
          return SizedBox(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
                        child: PhotoView(
                          imageProvider: MemoryImage(snapshot.requireData),
                          backgroundDecoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          loadingBuilder: (context, event) => Container(),
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
    );
  }
}

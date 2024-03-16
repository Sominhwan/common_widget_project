
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:common_project/views/search/search_view.dart';
import 'package:common_project/widget/advertisement_widget.dart';
import 'package:common_project/widget/signature_widget.dart';
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
  Uint8List? signature = Uint8List.fromList([
    // 간단한 예시 데이터입니다. 실제 PNG 데이터를 사용해야 합니다.
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
    // 이 부분에 PNG 파일의 나머지 데이터가 들어가야 합니다.
  ]);
  Uint8List? saveSignatureValue;

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
            child: const Text('검색 위젯'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return FractionallySizedBox(
                    heightFactor: 1.0,
                    child: Container(
                      color: const Color.fromRGBO(248, 248, 248, 1),
                      child: const SearchView(),
                    ),
                  );
                },
              );
            },
          ),
          InkWell(
            child: const Text('서명 위젯'),
            onTap: () async {
              Uint8List? signatureValue = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                ),
                builder: (context) {
                  return SignatureWidget(
                    widgetTitle: '서명',
                    initialValue: signature,
                  );
                },
              );
              if(signatureValue != null) {
                setState(() {
                  saveSignatureValue = signatureValue;
                  log(saveSignatureValue.toString());
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

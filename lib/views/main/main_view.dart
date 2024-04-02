
import 'dart:developer';
import 'dart:typed_data';

import 'package:common_project/views/emergency_guide_map_manage/emergency_guide_map_manage_view.dart';
import 'package:common_project/views/page1/page1_view.dart';
import 'package:common_project/views/safety_inspection_manage/safety_inspection_manage_detail_view.dart';
import 'package:common_project/views/search/search_view.dart';
import 'package:common_project/views/sign_up/sign_up_view.dart';
import 'package:common_project/widget/advertisement_widget.dart';
import 'package:common_project/widget/confirm_cancel_dialog_widget.dart';
import 'package:common_project/widget/custom_calendar_widget.dart';
import 'package:common_project/widget/custom_date_selector_widget.dart';
import 'package:common_project/widget/custom_dialog_widget.dart';
import 'package:common_project/widget/custom_toast_widget.dart';
import 'package:common_project/widget/select_item_widget.dart';
import 'package:common_project/widget/signature_widget.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();

  static String get className => 'MainView';
  static String get path => '/main';
}

class _MainViewState extends State<MainView> {
  /// 서명 위젯 변수
  Uint8List? signature = Uint8List.fromList([
    // 간단한 예시 데이터입니다. 실제 PNG 데이터를 사용해야 합니다.
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
    // 이 부분에 PNG 파일의 나머지 데이터가 들어가야 합니다.
  ]);
  Uint8List? saveSignatureValue;
  /// 선택 위젯 변수
  List<String> dropDownList = ['10', '20', '30'];
  String selectValue = '10';
  /// 커스텀 달력
  Map<DateTime, List<Event>> events = {
    DateTime.utc(2024,3,13) : [ Event('title'), Event('title2') ],
    DateTime.utc(2024,3,14) : [ Event('title3') ],
  };
  /// 달력 초기값 셋팅
  DateTime selectedDt = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 광고 위젯
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
                    child: AdvertisementWidget(
                      onChanged: (bool value) {
                        log(value.toString());
                      },
                    ),
                  );
                },
              );
            },
          ),
          /// 검색 위젯
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
          /// 서명 위젯
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
          /// 선택 위젯
          InkWell(
            child: const Text('선택 위젯'),
            onTap: () async {
              String? value = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                ),
                builder: (context) {
                  return SelectItemWidget(
                    dropDownList: dropDownList,
                    selectedValue: selectValue,
                  );
                },
              );
              setState(() {
                log('선택한 값 $value');
                if(value != null) {
                  selectValue = value;
                }
              });
            },
          ),
          /// 커스텀 토스트 위젯
          InkWell(
            child: const Text('커스텀 토스트 위젯'),
            onTap: () {
              CustomToastWidget.showToast(context, '저장완료 되었습니다!', false, null);
            },
          ),
          /// 커스텀 다이얼로그 위젯
          InkWell(
            child: const Text('커스텀 다이얼로그 위젯'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomDialogWidget();
                  },
              );
            },
          ),
          /// 커스텀 달력 위젯
          InkWell(
            child: const Text('커스텀 달력 위젯'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDateSelectorWidget(
                    selectedDt: DateTime.now(), // Current date as placeholder
                    minDt: DateTime(2020), // Minimum date as placeholder
                    maxDt: DateTime(2025), // Maximum date as placeholder
                    onChanged: (DateTime newDate) {
                      // Handle date change. Replace this with your logic.
                      print(newDate);
                    },
                    event: events,
                    // Assuming 'event' parameter is optional and not required for demonstration
                  );
                },
              );
            },
          ),
          /// 커스텀 달력(스케줄) 위젯
          InkWell(
            child: const Text('커스텀 달력(스케줄) 위젯'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomCalendarWidget(
                    onChanged: (DateTime newDate) {
                      // Handle date change. Replace this with your logic.
                      print(newDate);
                      setState(() {
                        selectedDt = newDate;
                      });
                    },
                    selectedDt: selectedDt,
                  );
                },
              );
            },
          ),
          /// 취소 확인 다이얼로그
          InkWell(
            child: const Text('커스텀 다이얼로그 위젯'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ConfirmCancelDialogWidget(
                    title: '삭제하시겠습니까?',
                    onChanged: (bool value) {
                        print('값 ${value}');
                    },
                  );
                },
              );
            },
          ),
          /// 페이지 이동
          InkWell(
            child: const Text('탭 페이지'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Page1View()),
              );
            },
          ),
          /// 사진 뷰어 페이지
          InkWell(
            child: const Text('사진 뷰어 페이지'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EmergencyGuideMapManageView()),
              );
            },
          ),
          /// 회원 가입 페이지
          InkWell(
            child: const Text('회원가입 페이지'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpView()),
              );
            },
          ),
          /// 설문조사 페이지
          InkWell(
            child: const Text('설문조사 페이지'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SafetyInspectionManageDetailView()),
              );
            },
          ),
          /// select box
          InkWell(
            child: const Text('선택 박스'),
            onTap: () async {
              // 위치에 따라 메뉴 표시
              final value = await showMenu(
                context: context,
                surfaceTintColor: Colors.white,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.transparent)
                ),
                items: [
                  const PopupMenuItem(
                    value: 'delete',
                    height: 35,
                    child: Text('삭제하기'),
                  ),
                  const PopupMenuItem(
                    value: 'cancel',
                    height: 35,
                    child: Text('취소'),
                  ),
                ],
                elevation: 5.0,
                position: const RelativeRect.fromLTRB(10, 0, 0, 0),
              );
            },
          )
        ],
      ),
    );
  }
}

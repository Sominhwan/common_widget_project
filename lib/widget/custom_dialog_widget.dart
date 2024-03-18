import 'package:flutter/material.dart';

class CustomDialogWidget extends StatefulWidget {
  const CustomDialogWidget({super.key});

  @override
  State<CustomDialogWidget> createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
  @override
  Widget build(BuildContext context) {
    // MediaQuery를 사용하여 디바이스의 크기를 얻습니다.
    final deviceSize = MediaQuery.of(context).size;

    return Dialog( // Dialog 위젯을 사용하여 다이얼로그의 크기와 모양을 조절
      //insetPadding: EdgeInsets.all(30), // 다이얼로그와 화면 가장자리 사이의 패딩
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder( // 모서리를 둥글게 처리합니다.
        borderRadius: BorderRadius.circular(20), // 모서리의 둥근 정도 설정
      ),
      child: SizedBox(
        width: deviceSize.width * 0.8,
        height: deviceSize.height * 0.3,
        child: const Center(
          child: Text('나는 커스텀 다이얼로그입니다.'),
        ),
      ),
    );
  }
}
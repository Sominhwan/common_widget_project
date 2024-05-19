import 'package:flutter/material.dart';

class CustomDialogWidget extends StatefulWidget {
  const CustomDialogWidget({super.key});

  @override
  State<CustomDialogWidget> createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Dialog(
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
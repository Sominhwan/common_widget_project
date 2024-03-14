import 'package:flutter/material.dart';

class AdvertisementWidget extends StatefulWidget {
  const AdvertisementWidget({
    super.key,
  });

  @override
  State<AdvertisementWidget> createState() => _AdvertisementWidgetState();
}

class _AdvertisementWidgetState extends State<AdvertisementWidget> {
  bool checkboxFlag = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: screenHeight/2 -50),
          // 서명 값이 존재하는 경우
          Container(
            width: double.maxFinite,
            height: 50,
            decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 0.2),
                ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 5),
                InkWell(
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 0.8, // 원하는 배율로 조정
                        child: Checkbox(
                          value: checkboxFlag,
                          onChanged: (value) {
                            setState(() {
                              checkboxFlag = value!;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          side: MaterialStateBorderSide.resolveWith((states) {
                            return const BorderSide(color: Colors.grey, width: 1);
                          }),
                          visualDensity: VisualDensity.compact,
                          checkColor: Colors.grey, // 체크 마크 색상
                          activeColor: Colors.white, // 박스 배경 색상
                        ),
                      ),
                      const Text(
                        '일주일동안 보지않기',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      checkboxFlag = !checkboxFlag;
                    });
                  },
                ),
                const Spacer(),
                InkWell(
                  child: const Text(
                    '닫기',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(null);
                  },
                ),

                const SizedBox(width: 15),
              ],
            ),
          )
        ],
      ),
    );
  }
}

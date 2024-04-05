
import 'package:flutter/material.dart';

class CustomerQAWriteView extends StatefulWidget {
  static String get className => 'CustomerQAWriteView';
  static String get path => '/customerSupportQAWrite';

  const CustomerQAWriteView({super.key});

  @override
  State<StatefulWidget> createState() => _CustomerQAWriteViewState();
}

class _CustomerQAWriteViewState extends State<CustomerQAWriteView> {
  late final formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('고객문의 작성'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
                height: 15
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          /// 고객지원 제목
                          const Text('제목', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    hintText: '제목',
                                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  ),
                                  enabled: true,
                                  style: const TextStyle(color: Colors.black), // 텍스트 색상 변경
                                  onSaved: (newValue) {},
                                  validator: (value) => value == '' ? '필수입력입니다.' : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          /// 문제내용
                          const Text('문제내용', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical, // 세로 스크롤 활성화
                            child: TextFormField(
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                hintText: '내용을 입력하세요.',
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                              maxLines: 10, // 스크롤을 가능하게 하려면 maxLines를 null로 설정
                              maxLength: null,
                              readOnly: false, // 사용자 입력을 막고 스크롤만 가능하게 설정
                              style: const TextStyle(color: Colors.black, fontSize: 16),
                              onSaved: (newValue) {
                              },
                              validator: (value) =>
                              value == '' ? '필수입력입니다.' : null,
                            ),
                          ),
                          const SizedBox(height: 20),
                          /// 수정요청일
                          Row(
                            children: [
                              const Text('수정 요청일 : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                              // DateSelectorCustom(
                              //   selectedDt: DateTime.now(),
                              //   minDt: DateTime(2010),
                              //   maxDt: DateTime(2030, 12, 31),
                              //   readOnly: false,
                              //   fontWeight: FontWeight.normal,
                              //   onChanged: (value) {
                              //   },
                              // ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text('수정/추가 요청사항', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical, // 세로 스크롤 활성화
                            child: TextFormField(
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                hintText: '요청사항을 입력하세요.',
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                              maxLines: 6,
                              maxLength: null,
                              readOnly: false, // 사용자 입력을 막고 스크롤만 가능하게 설정
                              style: const TextStyle(color: Colors.black, fontSize: 16),
                              onSaved: (newValue) {
                              },
                              validator: (value) =>
                              value == '' ? '필수입력입니다.' : null,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // SizedBox(
                          //   child: IFileManageField(
                          //     iFileManageController: fileController,
                          //     previewTitle: '사진 미리보기',
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}

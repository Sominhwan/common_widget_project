
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../widget/signature_widget.dart';

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
    _tabController = TabController(length: 2, vsync: this, animationDuration: Duration.zero, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('탭 예제'),
      ),
      body: Column(
        children: [
          // 탭바 배치
          Padding(
            padding: const EdgeInsets.all(0),
            child: TabBar(
              controller: _tabController,
              splashFactory: NoSplash.splashFactory,
              indicatorColor: Colors.blueAccent,
              splashBorderRadius: BorderRadius.circular(40),
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: const TextStyle(fontSize: 20),
              labelStyle: const TextStyle(fontSize: 20),
              labelColor: Colors.black,
              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
              tabs: const [
                Tab(child: Text('비상대응 시나리오', style: TextStyle(fontSize: 14))),
                Tab(child: Text('비상훈련 실시 보고서', style: TextStyle(fontSize: 14))),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Center(child: EmergencyResponseSenarioWidget()),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Center(child: Text('탭 2의 내용')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmergencyResponseSenarioWidget extends StatefulWidget {
  const EmergencyResponseSenarioWidget({super.key});

  @override
  State<EmergencyResponseSenarioWidget> createState() => _EmergencyResponseSenarioWidgetState();
}

class _EmergencyResponseSenarioWidgetState extends State<EmergencyResponseSenarioWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  Uint8List? signature;
  Uint8List? signature2;

  @override
  Widget build(BuildContext context) {
    double signFieldWidth = MediaQuery.of(context).size.width / 1.75;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 서명 테이블
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: signFieldWidth,
              child: Table(
                border: TableBorder.all(color: Colors.grey),
                columnWidths: const {
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          height: 20.0,
                          width: 30,
                          color: Colors.white,
                          child: const Center(
                            child: Text('검토자'),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          height: 20.0,
                          width: 30,
                          color: Colors.white,
                          child: const Center(
                            child: Text('승인자'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          height: 55.0,
                          color: Colors.white,
                          child: Center(
                            child: InkWell(
                              child: FormField<Uint8List?>(
                                key: formKey,
                                initialValue: signature,
                                enabled: true,
                                builder: (field) {
                                  final isValidSignature = field.value != null && field.value!.isNotEmpty;
                                  return Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      InputDecorator(
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(8),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(220, 220, 220, 1),
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        child: isValidSignature
                                            ? SizedBox(
                                          height: 100,
                                          width: double.infinity,
                                          child: Image.memory(
                                            field.value!,
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                            : const SizedBox(
                                          height: 100,
                                          child: Center(
                                            child: Text('서명 추가', style: TextStyle(color: Color.fromRGBO(220, 220, 220, 1))),
                                          ),
                                        ),
                                      ),
                                      if(isValidSignature)
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 5),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  signature = null;
                                                  formKey = GlobalKey<FormState>();
                                                });
                                              },
                                              child: const Icon(Icons.clear, size: 18),
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
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
                                    log('나는');
                                    signature = signatureValue;
                                    formKey = GlobalKey<FormState>();
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          height: 55.0,
                          color: Colors.white,
                          child: Center(
                            child: InkWell(
                              child: FormField<Uint8List?>(
                                key: formKey2,
                                initialValue: signature2,
                                enabled: true,
                                builder: (field) {
                                  final isValidSignature = field.value != null && field.value!.isNotEmpty;
                                  return InputDecorator(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(220, 220, 220, 1),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    child: isValidSignature
                                        ? SizedBox(
                                      height: 100,
                                      width: double.maxFinite,
                                      child: Image.memory(
                                        field.value!,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                        : const SizedBox(
                                      height: 100,
                                      child: Center(
                                        child: Text('서명 추가', style: TextStyle(color: Color.fromRGBO(220, 220, 220, 1))), // 대체 텍스트를 표시
                                      ),
                                    ),
                                  );
                                },
                              ),
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
                                      initialValue: signature2,
                                    );
                                  },
                                );
                                if(signatureValue != null) {
                                  setState(() {
                                    log('나는');
                                    signature2 = signatureValue;
                                    formKey2 = GlobalKey<FormState>();
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        /// 비상사태명
        const SizedBox(height: 10),
        const Text('비상사태명', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
        TextFormField(
          // controller: _textInputController,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: Color.fromRGBO(203, 203, 203, 0.3),
            hintText: '비상사태명',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
          enabled: true,
          style: const TextStyle(color: Colors.black), // 텍스트 색상 변경
          initialValue: '테스트',
          maxLines: null,
          onSaved: (newValue) {},
          validator: (value) =>
          value == '' ? '필수입력입니다.' : null,
        ),
        /// 장소
        const SizedBox(height: 10),
        const Text('장소', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
        TextFormField(
          // controller: _textInputController,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: Color.fromRGBO(203, 203, 203, 0.3),
            hintText: '장소',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
          enabled: true,
          style: const TextStyle(color: Colors.black), // 텍스트 색상 변경
          initialValue: '테스트',
          maxLines: null,
          onSaved: (newValue) {},
          validator: (value) =>
          value == '' ? '필수입력입니다.' : null,
        ),
        /// 발생내용
        const SizedBox(height: 10),
        const Text('발생내용', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
        TextFormField(
          // controller: _textInputController,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: Color.fromRGBO(203, 203, 203, 0.3),
            hintText: '발생내용',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
          enabled: true,
          style: const TextStyle(color: Colors.black), // 텍스트 색상 변경
          initialValue: '테스트',
          maxLines: null,
          onSaved: (newValue) {},
          validator: (value) =>
          value == '' ? '필수입력입니다.' : null,
        ),
        /// 예상되는 피해
        const SizedBox(height: 10),
        const Text('예상되는 피해 (안전보건영향)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
        TextFormField(
          // controller: _textInputController,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: Color.fromRGBO(203, 203, 203, 0.3),
            hintText: '예상되는 피해',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
          enabled: true,
          style: const TextStyle(color: Colors.black), // 텍스트 색상 변경
          initialValue: '테스트',
          maxLines: null,
          onSaved: (newValue) {},
          validator: (value) =>
          value == '' ? '필수입력입니다.' : null,
        ),
        /// 행동요령
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text('행동요령', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            Table(
              columnWidths: const {
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text('목표시간', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 5, right: 250),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Color.fromRGBO(203, 203, 203, 0.3),
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        ),
                        enabled: true,
                        style: const TextStyle(color: Colors.black),
                        initialValue: '1분',
                        maxLines: 1,
                        onSaved: (newValue) {
                          // Handle save
                        },
                        validator: (value) {
                          return value != null && value.isEmpty ? '필수입력입니다.' : null;
                        },
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8, top: 5), // Add some spacing between the text and the text field
                      child: Text('비고', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Color.fromRGBO(203, 203, 203, 0.3),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                      enabled: true,
                      style: const TextStyle(color: Colors.black),
                      initialValue: '2분',
                      maxLines: null,
                      onSaved: (newValue) {
                        // Handle save
                      },
                      validator: (value) {
                        return value != null && value.isEmpty ? '필수입력입니다.' : null;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 5),
        TextFormField(
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: Color.fromRGBO(203, 203, 203, 0.3),
            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
          enabled: true,
          style: const TextStyle(color: Colors.black),
          initialValue: '비고',
          maxLines: null,
          onSaved: (newValue) {
          },
          validator: (value) {
            return value != null && value.isEmpty ? '필수입력입니다.' : null;
          },
        ),
      ],
    );
  }
}

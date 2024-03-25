

import 'package:flutter/material.dart';

class SignUpInfoView extends StatefulWidget {
  const SignUpInfoView({super.key});

  static String get className => 'SignUpInfoView';
  static String get path => '/signUpInfo';
  @override
  State<SignUpInfoView> createState() => _SignUpInfoViewState();
}

class _SignUpInfoViewState extends State<SignUpInfoView> {
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  late bool passwordFlag = false;
  bool _obscureText = true;
  @override
  void initState() {
    super.initState();
    // 리스너 추가: 사용자가 텍스트 필드에 입력할 때마다 UI 업데이트
    _controller.addListener(() {
      setState(() {
        // 이 코드 블록은 _controller의 텍스트가 변경될 때마다 실행됩니다.
      });
    });
    _pwController.addListener(() {
      setState(() {
        // 이 코드 블록은 _controller의 텍스트가 변경될 때마다 실행됩니다.
      });
    });
  }

  @override
  void dispose() {
    // 위젯이 dispose될 때 리스너 제거 및 컨트롤러 해제
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic, // Align based on text baseline
                          children: [
                            Text('이름', style: TextStyle(color: Colors.black, fontSize: 14)),
                            Baseline(
                              baselineType: TextBaseline.alphabetic,
                              baseline: BorderSide.strokeAlignCenter,
                              child: Text(' *', style: TextStyle(fontSize: 14, color: Colors.red)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _controller,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.zero,), // 기본 테두리 색상
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(203, 203, 203, 1)), borderRadius: BorderRadius.zero,), // 비활성화 상태의 테두리 색상
                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.zero), // 활성화 상태의 테두리 색상
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '실명 입력',
                            hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            errorStyle: const TextStyle(color: Colors.redAccent),
                            errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent), borderRadius: BorderRadius.zero),
                            focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent), borderRadius: BorderRadius.zero),
                            suffixIcon: _controller.text.isNotEmpty ?
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: const Icon(Icons.cancel, color: Colors.grey,),
                              onTap: () {
                                _controller.clear();
                                setState(() {});
                              },
                            ) : null,
                          ),
                          enabled: true,
                          style: const TextStyle(color: Colors.black), // 텍스트 색상 변경
                          maxLines: 1,
                          onChanged: (value) {

                          },
                          validator: (value) => value == '' ? '필수 입력 항목입니다.' : null,
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic, // Align based on text baseline
                          children: [
                            Text('비밀번호', style: TextStyle(color: Colors.black, fontSize: 14)),
                            Baseline(
                              baselineType: TextBaseline.alphabetic,
                              baseline: BorderSide.strokeAlignCenter,
                              child: Text(' *', style: TextStyle(fontSize: 14, color: Colors.red)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _pwController,
                          keyboardType: TextInputType.visiblePassword,
                          maxLength: null,
                          style: const TextStyle(color: Colors.black),
                          onSaved: (value) {

                          },
                          validator: (value) => value == '' ? '필수 입력 항목입니다.' : null,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.zero,), // 기본 테두리 색상
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(203, 203, 203, 1)), borderRadius: BorderRadius.zero,), // 비활성화 상태의 테두리 색상
                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.zero), // 활성화 상태의 테두리 색상
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '비밀번호 입력',
                            hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            errorStyle: const TextStyle(color: Colors.redAccent),
                            errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent), borderRadius: BorderRadius.zero),
                            focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent), borderRadius: BorderRadius.zero),
                            suffixIcon: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(width: 5),
                                      _pwController.text.isNotEmpty ?
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: const Icon(Icons.cancel, color: Colors.grey,),
                                        onTap: () {
                                          _pwController.clear();
                                          setState(() {});
                                        },
                                      ) : const SizedBox.shrink(),
                                      const SizedBox(width: 5),
                                      if (passwordFlag) ...[
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _pwController.clear();
                                            });
                                          },
                                          child: Container(
                                            color: Colors
                                                .transparent, // 클릭 영역을 명확히 하기 위해 투명한 배경 색상 추가
                                            padding: EdgeInsets.zero, // 여기서는 패딩을 제거
                                            child: const Icon(
                                                Icons.clear), // Icon 크기를 직접 지정
                                          ),
                                        ),
                                      ],
                                      const SizedBox(width: 3),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                        child: Container(
                                          color: Colors.transparent, // 클릭 영역을 명확히 하기 위해
                                          padding: EdgeInsets.zero, // 패딩 최소화
                                          child: Icon(_obscureText
                                              ? Icons.visibility_off
                                              : Icons
                                              .visibility, color: Colors.grey, // Icon 크기 지정
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          if(formKey.currentState!.validate()) {
            formKey.currentState!.save();
            // _fileController?.save();
          }
        },
        child: Container(
          width: double.infinity,
          height: 50,
          color: const Color.fromRGBO(220, 220, 220, 1),
          child: const Center(
              child: Text('다음', style: TextStyle(color: Colors.white, fontSize: 18))
          ),
        )
      ),
    );
  }
}

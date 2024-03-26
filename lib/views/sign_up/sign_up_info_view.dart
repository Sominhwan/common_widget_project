

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _rePwController = TextEditingController();
  late bool _isDuplicateCheckRequired = false; // 중복확인 validator 상태 관리 변수 추가
  late bool passwordFlag = false;
  late bool passwordFlag2 = false;
  bool _obscureText = true;
  bool _obscureText2 = true;
  @override
  void initState() {
    super.initState();
    // 리스너 추가: 사용자가 텍스트 필드에 입력할 때마다 UI 업데이트
    _nameController.addListener(() {
      setState(() {});
    });
    _emailController.addListener(() {
      setState(() {});
    });
    _idController.addListener(() {
      setState(() {});
    });
    _pwController.addListener(() {
      setState(() {});
    });
    _rePwController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // 위젯이 dispose될 때 리스너 제거 및 컨트롤러 해제
    _nameController.dispose();
    _pwController.dispose();
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
                        /// 이름
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
                          controller: _nameController,
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
                            suffixIcon: _nameController.text.isNotEmpty ?
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: const Icon(Icons.cancel, color: Colors.grey,),
                              onTap: () {
                                _nameController.clear();
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
                        /// 이메일
                        const SizedBox(height: 20),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic, // Align based on text baseline
                          children: [
                            Text('이메일', style: TextStyle(color: Colors.black, fontSize: 14)),
                            Baseline(
                              baselineType: TextBaseline.alphabetic,
                              baseline: BorderSide.strokeAlignCenter,
                              child: Text(' *', style: TextStyle(fontSize: 14, color: Colors.red)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _emailController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.zero,), // 기본 테두리 색상
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(203, 203, 203, 1)), borderRadius: BorderRadius.zero,), // 비활성화 상태의 테두리 색상
                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.zero), // 활성화 상태의 테두리 색상
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '이메일 입력',
                            hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            errorStyle: const TextStyle(color: Colors.redAccent),
                            errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent), borderRadius: BorderRadius.zero),
                            focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent), borderRadius: BorderRadius.zero),
                            suffixIcon: _emailController.text.isNotEmpty ?
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: const Icon(Icons.cancel, color: Colors.grey,),
                              onTap: () {
                                _emailController.clear();
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
                        /// 아이디
                        const SizedBox(height: 20),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic, // Align based on text baseline
                          children: [
                            Text('아이디', style: TextStyle(color: Colors.black, fontSize: 14)),
                            Baseline(
                              baselineType: TextBaseline.alphabetic,
                              baseline: BorderSide.strokeAlignCenter,
                              child: Text(' *', style: TextStyle(fontSize: 14, color: Colors.red)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _idController,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.zero,), // 기본 테두리 색상
                                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(203, 203, 203, 1)), borderRadius: BorderRadius.zero,), // 비활성화 상태의 테두리 색상
                                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.zero), // 활성화 상태의 테두리 색상
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: '아이디 입력',
                                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                    errorStyle: const TextStyle(color: Colors.redAccent),
                                    helperText: "",
                                    errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent), borderRadius: BorderRadius.zero),
                                    focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent), borderRadius: BorderRadius.zero),
                                    suffixIcon: _idController.text.isNotEmpty ?
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: const Icon(Icons.cancel, color: Colors.grey,),
                                      onTap: () {
                                        _idController.clear();
                                        setState(() {});
                                      },
                                    ) : null,
                                  ),
                                  enabled: true,
                                  style: const TextStyle(color: Colors.black), // 텍스트 색상 변경
                                  maxLines: 1,
                                  onChanged: (value) {

                                  },
                                  validator: (value) {
                                    if (_isDuplicateCheckRequired) {
                                      return '중복 확인이 필요합니다.'; // 조건에 따른 메시지 변경
                                    }
                                    return value == '' ? '필수 입력 항목입니다.' : null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 5),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: InkWell(
                                      child: Container(
                                        width: 95,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color.fromRGBO(203, 203, 203, 1), // Set border color
                                            width: 1.0, // Set border width
                                          ),
                                          color: Colors.blueAccent
                                        ),
                                        alignment: Alignment.center,
                                        child: const Text('중복 확인', style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _isDuplicateCheckRequired = true; // 상태 업데이트
                                          formKey.currentState!.validate();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        /// 비밀번호
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
                        /// 비밀번호 재입력
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _rePwController,
                          keyboardType: TextInputType.visiblePassword,
                          maxLength: null,
                          style: const TextStyle(color: Colors.black),
                          onSaved: (value) {

                          },
                          validator: (value) => value == '' ? '필수 입력 항목입니다.' : null,
                          obscureText: _obscureText2,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.zero,), // 기본 테두리 색상
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(203, 203, 203, 1)), borderRadius: BorderRadius.zero,), // 비활성화 상태의 테두리 색상
                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.zero), // 활성화 상태의 테두리 색상
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '비밀번호 재입력',
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
                                      _rePwController.text.isNotEmpty ?
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: const Icon(Icons.cancel, color: Colors.grey,),
                                        onTap: () {
                                          _rePwController.clear();
                                          setState(() {});
                                        },
                                      ) : const SizedBox.shrink(),
                                      const SizedBox(width: 5),
                                      if (passwordFlag2) ...[
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _rePwController.clear();
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
                                            _obscureText2 = !_obscureText2;
                                          });
                                        },
                                        child: Container(
                                          color: Colors.transparent, // 클릭 영역을 명확히 하기 위해
                                          padding: EdgeInsets.zero, // 패딩 최소화
                                          child: Icon(_obscureText2
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
                        const SizedBox(height: 20),
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

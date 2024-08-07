

import 'dart:developer';

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
  final TextEditingController _phoneNumController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _idFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _rePasswordFocus = FocusNode();
  final FocusNode _phoneNumFocus = FocusNode();

  late bool _isDuplicateCheckRequired = false;
  late bool passwordFlag = false;
  late bool passwordFlag2 = false;
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _isNextButtonEnabled = false;

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _updateNextButtonState() {
    final allFieldsFilled = _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _idController.text.isNotEmpty &&
        _pwController.text.isNotEmpty &&
        _rePwController.text.isNotEmpty &&
        _phoneNumController.text.isNotEmpty;

    setState(() {
      _isNextButtonEnabled = allFieldsFilled;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      _updateNextButtonState();
      setState(() {});
    });
    _emailController.addListener(() {
      _updateNextButtonState();
      setState(() {});
    });
    _idController.addListener(() {
      _updateNextButtonState();
      if (!_isDuplicateCheckRequired && _idController.text.isNotEmpty) {
        setState(() {
          _isDuplicateCheckRequired = true;
        });
      }
    });
    _pwController.addListener(() {
      _updateNextButtonState();
      setState(() {});
    });
    _rePwController.addListener(() {
      _updateNextButtonState();
      setState(() {});
    });
    _phoneNumController.addListener(() {
      _updateNextButtonState();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _emailFocus.dispose();
    _idFocus.dispose();
    _passwordFocus.dispose();
    _rePasswordFocus.dispose();
    _phoneNumFocus.dispose();
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
                            Text('성명', style: TextStyle(color: Colors.black, fontSize: 14)),
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
                          focusNode: _nameFocus,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, _nameFocus, _emailFocus);
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.zero,), // 기본 테두리 색상
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(203, 203, 203, 1)), borderRadius: BorderRadius.zero,), // 비활성화 상태의 테두리 색상
                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.zero), // 활성화 상태의 테두리 색상
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '실명 입력',
                            prefixText: '  ',
                            hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
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
                          style: const TextStyle(color: Colors.black),
                          maxLines: 1,
                          onChanged: (value) {

                          },
                          validator: (value) => value == '' ? '필수 입력 항목입니다.' : null,
                        ),
                        /// 이메일
                        const SizedBox(height: 20),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
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
                          focusNode: _emailFocus,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, _emailFocus, _idFocus);
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.zero,), // 기본 테두리 색상
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(203, 203, 203, 1)), borderRadius: BorderRadius.zero,), // 비활성화 상태의 테두리 색상
                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.zero), // 활성화 상태의 테두리 색상
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '이메일 입력',
                            hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                            prefixText: '  ',
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
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
                          style: const TextStyle(color: Colors.black),
                          maxLines: 1,
                          onChanged: (value) {

                          },
                          validator: (value) => value == '' ? '필수 입력 항목입니다.' : null,
                        ),
                        /// 아이디
                        const SizedBox(height: 20),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
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
                                  focusNode: _idFocus,
                                  onFieldSubmitted: (term) {
                                    _fieldFocusChange(context, _idFocus, _passwordFocus); // 다음 필드로 포커스 이동
                                  },
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.zero,), // 기본 테두리 색상
                                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(203, 203, 203, 1)), borderRadius: BorderRadius.zero,), // 비활성화 상태의 테두리 색상
                                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.zero), // 활성화 상태의 테두리 색상
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: '아이디 입력',
                                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                                    prefixText: '  ',
                                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
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
                                  style: const TextStyle(color: Colors.black),
                                  maxLines: 1,
                                  onChanged: (value) {

                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '필수 입력 항목입니다.';
                                    } else if (_isDuplicateCheckRequired) {
                                      log('중복확인');
                                      return '아이디 중복 확인이 필요합니다.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 5),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 48,
                                    child: InkWell(
                                      child: Container(
                                        width: 90,
                                        decoration: const BoxDecoration(
                                          border: null,
                                          color: Colors.blueAccent
                                        ),
                                        alignment: Alignment.center,
                                        child: const Text('중복 확인', style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _isDuplicateCheckRequired = false;
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
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
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
                          focusNode: _passwordFocus,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, _passwordFocus, _rePasswordFocus);
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.zero,), // 기본 테두리 색상
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(203, 203, 203, 1)), borderRadius: BorderRadius.zero,), // 비활성화 상태의 테두리 색상
                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.zero), // 활성화 상태의 테두리 색상
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '비밀번호 입력',
                            hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                            prefixText: '  ',
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
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
                                                .transparent,
                                            padding: EdgeInsets.zero,
                                            child: const Icon(
                                                Icons.clear),
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
                                          color: Colors.transparent,
                                          padding: EdgeInsets.zero,
                                          child: Icon(_obscureText
                                              ? Icons.visibility_off
                                              : Icons
                                              .visibility, color: Colors.grey,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '필수 입력 항목입니다.';
                            }
                            // 비밀번호와 비밀번호 재입력이 동일한지 확인
                            if (_pwController.text != _rePwController.text) {
                              return '비밀번호가 일치하지 않습니다.';
                            }
                            return null;
                          },
                          obscureText: _obscureText2,
                          focusNode: _rePasswordFocus,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, _rePasswordFocus, _phoneNumFocus);
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.zero,),
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(203, 203, 203, 1)), borderRadius: BorderRadius.zero,),
                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.zero),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '비밀번호 재입력',
                            hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                            prefixText: '  ',
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
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
                                        child: const Icon(Icons.cancel, color: Colors.grey),
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
                                                .transparent,
                                            padding: EdgeInsets.zero,
                                            child: const Icon(
                                                Icons.clear)
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
                                          color: Colors.transparent,
                                          padding: EdgeInsets.zero,
                                          child: Icon(_obscureText2
                                              ? Icons.visibility_off
                                              : Icons
                                              .visibility, color: Colors.grey,
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
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text('휴대폰 번호', style: TextStyle(color: Colors.black, fontSize: 14)),
                            Baseline(
                              baselineType: TextBaseline.alphabetic,
                              baseline: BorderSide.strokeAlignCenter,
                              child: Text(' *', style: TextStyle(fontSize: 14, color: Colors.red)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _phoneNumController,
                          cursorColor: Colors.black,
                          focusNode: _phoneNumFocus,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.zero,), // 기본 테두리 색상
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(203, 203, 203, 1)), borderRadius: BorderRadius.zero,), // 비활성화 상태의 테두리 색상
                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.zero), // 활성화 상태의 테두리 색상
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '휴대폰 번호 입력',
                            hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                            prefixText: '  ',
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                            errorStyle: const TextStyle(color: Colors.redAccent),
                            errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent), borderRadius: BorderRadius.zero),
                            focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent), borderRadius: BorderRadius.zero),
                            suffixIcon: _phoneNumController.text.isNotEmpty ?
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: const Icon(Icons.cancel, color: Colors.grey,),
                              onTap: () {
                                _phoneNumController.clear();
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          _isNextButtonEnabled ?
          InkWell(
              onTap: () {
                bool isValid = formKey.currentState!.validate();

                if (isValid && !_isDuplicateCheckRequired) {
                  formKey.currentState!.save();
                  log('이상 없음');
                } else {
                  if (!_isDuplicateCheckRequired) {

                  }
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                color: Colors.blueAccent,
                child: const Center(
                    child: Text('회원가입', style: TextStyle(color: Colors.white, fontSize: 18))
                ),
              )
          ) :
          InkWell(
              onTap: null,
              child: Container(
                width: double.infinity,
                height: 50,
                color: const Color.fromRGBO(220, 220, 220, 1),
                child: const Center(
                    child: Text('회원가입', style: TextStyle(color: Colors.white, fontSize: 18))
                ),
              )
          ),
        ],
      ),
    );
  }
}

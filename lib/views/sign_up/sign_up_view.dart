
import 'dart:math';
import 'package:common_project/views/sign_up/sign_up_info_view.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});
  static String get className => 'SignUpView';
  static String get path => '/signUp';


  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool allAgreed = false;
  bool termsAgreed = false;
  bool personalInfoAgreed = false;

  void _updateAllAgreed() {
    setState(() {
      if (termsAgreed && personalInfoAgreed) {
        allAgreed = true;
      } else {
        allAgreed = false;
      }
    });
  }

  void _updateAgreement(bool newValue, String type) {
    setState(() {
      switch (type) {
        case 'terms':
          termsAgreed = newValue;
          break;
        case 'personalInfo':
          personalInfoAgreed = newValue;
          break;
        default:
          break;
      }
      _updateAllAgreed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('약관동의'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text('회원가입', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Transform.scale(
                      scale: 0.8,
                      child: Checkbox(
                        value: allAgreed,
                        onChanged: (value) {
                          setState(() {
                            allAgreed = value!;
                            termsAgreed = personalInfoAgreed = allAgreed;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        side: MaterialStateBorderSide.resolveWith((states) {
                          return const BorderSide(color: Colors.grey, width: 1);
                        }),
                        visualDensity: VisualDensity.compact,
                        checkColor: Colors.white,
                        activeColor: Colors.blueAccent,
                      ),
                    ),
                    const Text('전체동의', style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),)
                  ],
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey, width: 0.2),
                      bottom: BorderSide(color: Colors.grey, width: 0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAgreementCheckbox('[필수] ', '서비스 이용약관', termsAgreed, 'terms'),
                      _buildAgreementCheckbox('[필수] ', '개인정보 수집 및 이용에 대한 동의', personalInfoAgreed, 'personalInfo')
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      /// 다음 버튼
      bottomNavigationBar: termsAgreed && personalInfoAgreed ?
      InkWell(
        child: Container(
          width: double.infinity,
          height: 50,
          color: Colors.blueAccent,
          child: const Center(
              child: Text('다음', style: TextStyle(color: Colors.white, fontSize: 18))
          ),
        ),
        onTap: () {
          setState(() {
            allAgreed = false;
            termsAgreed = false;
            personalInfoAgreed = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpInfoView()),
          );
        },
      ) :
      InkWell(
        onTap: null,
        child: Container(
          width: double.infinity,
          height: 50,
          color: const Color.fromRGBO(220, 220, 220, 1),
          child: const Center(
              child: Text('다음', style: TextStyle(color: Colors.white, fontSize: 18))
          ),
        )
      )
    );
  }

  Widget _buildAgreementCheckbox(String prefix, String text, bool isChecked, String type) {
    Color prefixColor = Colors.redAccent;

    return Row(
      children: [
        Transform.scale(
          scale: 0.8,
          child: Checkbox(
            value: isChecked,
            onChanged: (value) {
              _updateAgreement(value!, type);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            side: MaterialStateBorderSide.resolveWith((states) {
              return const BorderSide(color: Colors.grey, width: 1);
            }),
            visualDensity: VisualDensity.compact,
            checkColor: Colors.white,
            activeColor: Colors.blueAccent,
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Text(prefix, style: TextStyle(color: prefixColor)),
              Text(text, style: const TextStyle(color: Color.fromRGBO(120, 120, 120, 1))),
            ],
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Transform.rotate(
            angle: 90 * pi / 180,
            child: const Icon(Icons.expand_less, color: Color.fromRGBO(200, 200, 200, 1)),
          ),
          onTap: () {
            print('선택');
          },
        ),
      ],
    );
  }
}

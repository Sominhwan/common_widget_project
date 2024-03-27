import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:image/image.dart' as img;

class SignatureWidget extends StatefulWidget {
  final String widgetTitle;
  final Uint8List? initialValue;
  const SignatureWidget({
    super.key,
    required this.widgetTitle,
    this.initialValue
  });

  @override
  State<SignatureWidget> createState() => _SignatureWidgetState();
}

class _SignatureWidgetState extends State<SignatureWidget> {
  bool saveSignatureFlag = false;
  bool signatureLayoutFlag = false;

  late final signatureController = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportPenColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
    onDrawStart: () => setState(() {
      saveSignatureFlag = true;
    }),
    onDrawEnd: () => setState(() {

    }),
  );

  Future<void> _saveNewSign() async {
    if(widget.initialValue != null && !signatureLayoutFlag) {
      Navigator.of(context).pop(widget.initialValue);
    } else {
      await signatureController.toPngBytes().then((value) {
        if (value != null) {
          final decoded = img.decodePng(value)!;
          // 이미지 리사이징 시 품질 보존
          var resized = img.copyResize(decoded, height: decoded.height,
              width: decoded.width,
              interpolation: img.Interpolation.cubic);
          Uint8List signature = Uint8List.fromList(img.encodePng(resized));
          Navigator.of(context).pop(signature);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    signatureLayoutFlag = widget.initialValue == null;
    if(widget.initialValue != null) {
      saveSignatureFlag = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.widgetTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                InkWell(
                  child: const Icon(Icons.clear, size: 18),
                  onTap: () {
                    Navigator.of(context).pop(null);
                  },
                )
              ],
            ),
          ),
          if(widget.initialValue != null && !signatureLayoutFlag) ... [
            /// 서명값이 존재할시
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: FormField(
                initialValue: widget.initialValue,
                enabled: true,
                builder: (field) {
                  return InputDecorator(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(220, 220, 220, 1),
                            width: 1.0
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: 111,
                      child: Image.memory(
                        field.value!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
          if(signatureLayoutFlag) ... [
            /// 서명값 존재하지 않을시
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: 150,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(width: 1, color: const Color.fromRGBO(220, 220, 220, 1))
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Signature(
                        controller: signatureController,
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        backgroundColor: Colors.white,
                      );
                    }
                  ),
                ),
              ),
            ),
          ],
          if(widget.initialValue != null && !signatureLayoutFlag) ... [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1, color: const Color.fromRGBO(220, 220, 220, 1))
                    ),
                    child: InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('편집하기', style: TextStyle(fontSize: 14))
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          signatureLayoutFlag = true;
                          saveSignatureFlag = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
          if(signatureLayoutFlag) ... [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 1, color: const Color.fromRGBO(220, 220, 220, 1))
                        ),
                        child: InkWell(
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.refresh, size: 16),
                                SizedBox(width: 5),
                                Text('재설정', style: TextStyle(fontSize: 14))
                              ],
                            ),
                          ),
                          onTap: () {
                            signatureController.clear();
                            setState(() {
                              saveSignatureFlag = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if(widget.initialValue != null) ... [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 15, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1, color: const Color.fromRGBO(220, 220, 220, 1))
                          ),
                          child: InkWell(
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('기존 서명 사용', style: TextStyle(fontSize: 14))
                                ],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                signatureController.clear();
                                signatureLayoutFlag = false;
                                saveSignatureFlag = true;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ],
          const SizedBox(height: 10),
          if(saveSignatureFlag) ...[
            Container(
              width: double.maxFinite,
              height: 50,
              decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 0.2),
                  ),
                  color: Color.fromRGBO(86, 164, 255, 1)
              ),
              child: InkWell(
                onTap: () async {
                  await _saveNewSign();
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: const Center(
                  child: Text(
                    '저장하기',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ],
          if(!saveSignatureFlag) ... [
            Container(
              width: double.maxFinite,
              height: 50,
              decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 0.2),
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1)
              ),
              child: const InkWell(
                onTap: null,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Center(
                  child: Text(
                    '저장하기',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}


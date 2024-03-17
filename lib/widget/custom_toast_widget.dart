import 'package:flutter/material.dart';

class CustomToastWidget extends StatefulWidget {
  final VoidCallback onDismissed;
  final String text;
  final bool appIconFlag;
  final Color? backgroundColor;
  const CustomToastWidget({
    super.key,
    required this.onDismissed,
    required this.text,
    required this.appIconFlag,
    this.backgroundColor
  });

  static void showToast(BuildContext context, String text, bool appIconFlag, Color? backgroundColor) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => CustomToastWidget(
        onDismissed: ()  { },
        text: text,
        appIconFlag: appIconFlag,
        backgroundColor: backgroundColor ?? const Color.fromRGBO(100, 100, 100, 0.9)
      ),
    );
    Overlay.of(context).insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  @override
  CustomToastWidgetState createState() => CustomToastWidgetState();
}

class CustomToastWidgetState extends State<CustomToastWidget> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!);
    _controller!.forward();
    Future.delayed(const Duration(seconds: 2)).then((value) => _controller!.reverse().then((value) => widget.onDismissed()));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation!,
      child: Stack(
        alignment: Alignment.center, // Stack 내의 요소들을 중앙에 배치
        children: [
          Positioned(
            bottom: 20.0,
            child: Material(
              color: Colors.transparent,
              child: Container(
                constraints: BoxConstraints(
                  minWidth: 50, // 최소 너비를 설정
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  // color: const Color.fromRGBO(100, 100, 100, 0.9),
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(52),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(widget.appIconFlag) ... [
                      Image.asset('Assets/images/app_icon.png', width: 14),
                      const SizedBox(width: 8),
                    ],
                    Flexible(
                      child: Text(
                        widget.text,
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis, // 길이가 넘어갈 경우 말줄임표(...) 표시
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

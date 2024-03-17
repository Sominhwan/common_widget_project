
import 'package:flutter/material.dart';

class SelectItemWidget extends StatefulWidget {
  final List<String> dropDownList;
  final String selectedValue;

  const SelectItemWidget({
    super.key,
    required this.dropDownList,
    required this.selectedValue,
  });

  @override
  State<SelectItemWidget> createState() => _SelectItemWidgetState();
}

class _SelectItemWidgetState extends State<SelectItemWidget> {
  final GlobalKey _textKey = GlobalKey();
  double _textWidth = 0;

  void _calculateTextWidth() {
    final RenderBox renderBox = _textKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size.width;
    setState(() {
      _textWidth = size;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateTextWidth());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.dropDownList.length,
              itemBuilder: (context, index) {
                bool isSelected = widget.dropDownList[index] == widget.selectedValue;
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pop(widget.dropDownList[index]);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          widget.dropDownList[index],
                          key: isSelected ? _textKey : null,
                          textAlign: TextAlign.center,
                        ),
                        if (isSelected && _textWidth > 0)
                          Positioned(
                            right: MediaQuery.of(context).size.width / 2 - _textWidth / 2 - 20,
                            child: const Icon(Icons.check, size: 17, color: Colors.blue),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.maxFinite,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: Colors.grey,
                      width: 0.2
                  )
                )
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop(null);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: const Center(
                  child: Text(
                    '취소',
                    textAlign: TextAlign.center, // Text의 내용을 가운데 정렬합니다.
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

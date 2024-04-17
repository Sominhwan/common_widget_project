
import 'package:flutter/material.dart';

class TermsConditionsView extends StatefulWidget {
  final String? title;
  const TermsConditionsView({super.key, this.title});
  static String get className => 'TermsConditionsView';
  static String get path => '/termsConditions';

  @override
  State<TermsConditionsView> createState() => _TermsConditionsViewState();
}

class _TermsConditionsViewState extends State<TermsConditionsView> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const Column(
        children: [

        ],
      ),
    );
  }
}

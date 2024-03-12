import 'package:common_project/views/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

final routes = {
  MainView.path: (context) => const MainView(), // 메인화면
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          title: 'Kiest',
          localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
          Locale('ko'),
      ],
      debugShowCheckedModeBanner: false,
      //theme: esgConstTheme,
      routes: routes,
      //navigatorKey: NavigationService.navigatorKey,
      //onGenerateRoute: generateRoute,
      initialRoute: MainView.path,
      builder: EasyLoading.init(),
      );
  }
}


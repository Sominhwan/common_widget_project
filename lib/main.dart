import 'package:common_project/util/SharedPref.dart';
import 'package:common_project/views/main/main_view.dart';
import 'package:common_project/views/page1/page1_view.dart';
import 'package:common_project/views/search/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    SharedPref.init()
  ]);

  runApp(const MyApp());
}

final routes = {
  MainView.path: (context) => const MainView(), // 메인화면
  Page1View.path: (context) => const Page1View(), // 메인화면
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider())
      ],
      child: MaterialApp(
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
        ),
    );
  }
}


import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/features/home/presentation/home_screen.dart';
import 'package:ecommerce_app/features/splash/presentation/first_splash_screen.dart';
import 'package:ecommerce_app/localization/change_language.dart';
import 'package:flutter/gestures.dart';
import 'data/remote_data/core.dart';
import 'domain_data/get_binding/get_binding.dart';
import 'localization/Translation.dart';
import 'res/configuration/context.dart';
import 'res/router/pages.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

  final MainGetxController controller = Get.put(MainGetxController());
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(419, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: initData.title,
         theme: Context.getLightThemeData(),
        darkTheme: Context.getDarkThemeData(),
        themeMode: controller.isDark ? ThemeMode.dark : ThemeMode.light,

        // navigatorObservers: [ChuckerFlutter.navigatorObserver],
        initialBinding: GetBinding(),
        translations: Translation(),
        locale: Locale(TLang.getLocalLang().name),
        fallbackLocale: const Locale('en'),
        getPages: CustomPage.pages,
      // home: HomeScreen(), 
        home: const FirstSplashScreen(),
      
        builder: (context, child) {
  return MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
    child: child!,
  );
},

      ),
    );
  }
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('not Found page'),
      ),
    );
  }
}


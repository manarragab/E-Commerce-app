
import 'package:ecommerce_app/res/configuration/color.dart';
import 'package:ecommerce_app/res/configuration/image/custom_image.dart';
import 'package:ecommerce_app/res/router/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstSplashScreen extends StatefulWidget {
  const FirstSplashScreen({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<FirstSplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() {
    Future.delayed(const Duration(seconds: 1), () {
      // Uncomment and modify this section based on your routing
      // sPrint.info('getUser:: ${sl<AuthCases>().getUser() != null}');
      // if (sl<AuthCases>().getUser() != null) {
      //   Get.offAllNamed('/home'); // Use your actual route name
      // } else {
      //   Get.offAllNamed('/onboarding'); // Use your actual route name
      // }
            Get.offAllNamed(CustomPage.splashPage);

      // For testing, just navigate to a test page
      // Get.offAllNamed('/test'); // Make sure this route exists in CustomPage.pages
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.accentLight,
      body: Center(
        child:
         CustomImage.asset(
          'assets/svg/splash.svg',
          fit: BoxFit.fitWidth, 
          width: Get.width / 2, 
          height: Get.height / 2
        ),
      ),
    );
  }
}
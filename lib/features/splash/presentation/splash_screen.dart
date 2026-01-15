import 'package:ecommerce_app/data/data_sources/get_storage.dart';
import 'package:ecommerce_app/data/remote_data/dio_helper.dart';
import 'package:ecommerce_app/features/auth/domain/cases/auth_case.dart';
import 'package:ecommerce_app/features/auth/domain/controller/auth_controller.dart';
import 'package:ecommerce_app/features/home/domain/controller/home_controller.dart';
import 'package:ecommerce_app/features/payment/domain/controller/payment_controller.dart';
import 'package:ecommerce_app/res/common-widgets/custm_button.dart';
import 'package:ecommerce_app/res/configuration/fonts.dart';
import 'package:ecommerce_app/res/configuration/image/custom_image.dart';
import 'package:ecommerce_app/res/configuration/open_url/launch_url.dart';
import 'package:ecommerce_app/res/configuration/print_types.dart';
import 'package:ecommerce_app/res/injection.dart';
import 'package:ecommerce_app/res/loading/loading_overlay_widget.dart';
import 'package:ecommerce_app/res/router/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../res/injection.dart';
import '../domain/controller/splash_controller.dart';
import 'widget/splash_dots.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = Get.put(SplashController());


  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
  
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        child: Column(
          children: [
            // CustomImage.network(
            //   'https://upload.wikimedia.org/wikipedia/commons/c/c5/Gucci_logo.svg',
            //   height: 80,
            //   width: 80,
            // ),

            // Top bar
          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text(
                      "${controller.activeIndex.value + 1}/3",
                      style: TFonts.montFont(fontSize: 18),
                    )),
              
                LoadingOverLay(
                  showLoadingOnly: true,
                  child: GestureDetector(
                    onTap: () async {
  controller.loadingGetxController.showLoading();
final success = await authController.refreshToken();
if(sl<GetStorageData>().getToken() != null){
await controller.openHomePage();
       // Get.offAllNamed(CustomPage.homePage);

}
else{
if (success) {
  await controller.openHomePage();
} else {
  Get.offAllNamed(CustomPage.loginPage);
  controller.loadingGetxController.hideLoading();
}
}


},



                    child:  Text("Skip", style:  TFonts.montFont(fontSize: 18))),
                ),
              ],
            ),

            const Spacer(),

            // Image
            Obx(() => CustomImage.asset(
                  controller.images[controller.activeIndex.value],
                  height: 300,
                  width: 300,
                )),

            const SizedBox(height: 20),
// MainButton(onPressed: (){
// Get.toNamed(CustomPage.loginPage);
// },
//  title: "Get Started",
// ),
            // Title
            Obx(() => Text(
                  controller.txt1[controller.activeIndex.value],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )),

            const SizedBox(height: 15),

            const Text(
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),

            const Spacer(),

            // Bottom navigation
            Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: controller.prev,
                      child: const Text("Prev", style: TextStyle(fontSize: 18)),
                    ),
                    const SplashDots(),
                    GestureDetector(
                      onTap: controller.next,
                      child: const Text("Next", style: TextStyle(fontSize: 18)),
                    ),
                  ],
                )
          ],
        ),
      ),
    );
  }
  
}

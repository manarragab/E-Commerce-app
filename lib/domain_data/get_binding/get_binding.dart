import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/features/auth/domain/controller/auth_controller.dart';
import 'package:ecommerce_app/features/home/domain/controller/home_controller.dart';
import 'package:ecommerce_app/features/payment/domain/controller/payment_controller.dart';
import 'package:ecommerce_app/features/splash/domain/controller/splash_controller.dart';

class GetBinding extends Bindings {
  @override
  void dependencies() {
        Get.put(LoadingGetxController(), permanent: true);

        Get.put(MainGetxController(), permanent: true);
    Get.put(AuthController() , permanent: true);
    Get.put(SplashController(), permanent: true);
    Get.put(HomeController(),  permanent: true);
    Get.put(PaymentController(),  permanent: true);

  }
}

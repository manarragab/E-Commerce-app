
import 'package:ecommerce_app/features/auth/domain/controller/auth_controller.dart';
import 'package:ecommerce_app/features/auth/presentation/forget_password_screen.dart';
import 'package:ecommerce_app/features/auth/presentation/login_screen.dart';
import 'package:ecommerce_app/features/auth/presentation/otp_confirmation_screen.dart';
import 'package:ecommerce_app/features/auth/presentation/register_screen.dart';
import 'package:ecommerce_app/features/auth/presentation/reset_password_screen.dart';
import 'package:ecommerce_app/features/home/domain/controller/home_controller.dart';
import 'package:ecommerce_app/features/home/presentation/home_screen.dart';
import 'package:ecommerce_app/features/home/presentation/widget/products_screen.dart';
import 'package:ecommerce_app/features/payment/domain/controller/payment_controller.dart';
import 'package:ecommerce_app/features/payment/presentation/choose_pay_screen.dart';
import 'package:ecommerce_app/features/payment/presentation/payment_info_screen.dart';
import 'package:ecommerce_app/features/payment/presentation/shopping_screen.dart';
import 'package:ecommerce_app/features/splash/presentation/splash_screen.dart';
import 'package:get/get.dart';

class CustomPage {
  static List<GetPage> pages = [
     GetPage(
        name: splashPage,
        page: () =>  SplashScreen(),
        transition: Transition.fadeIn,
        binding: BindingsBuilder(() {
        })),


GetPage(
        name: homePage,
        page: () =>  HomeScreen(),
        transition: Transition.fadeIn,
        binding: BindingsBuilder(() {
        })),

GetPage(
        name: loginPage,
        page: () =>  LoginScreen(),
        transition: Transition.fadeIn,
        binding: BindingsBuilder(() {
           Get.put(AuthController());
        })),


GetPage(
        name: registerPage,
        page: () =>  RegisterScreen(),
        transition: Transition.fadeIn,
        binding: BindingsBuilder(() {
            Get.put(AuthController());
        })),


GetPage(
        name: forgetPasswordPage,
        page: () =>  ForgetPasswordScreen(),
        transition: Transition.fadeIn,
        binding: BindingsBuilder(() {
            Get.put(AuthController());
        })),

GetPage(
        name: otpPage,
        page: () =>  OtpConfirmationScreen(),
        transition: Transition.fadeIn,
        binding: BindingsBuilder(() {
            Get.put(AuthController()).startCount();
        })),

GetPage(
        name: resetPage,
        page: () =>  ResetPasswordScreen(),
        transition: Transition.fadeIn,
        binding: BindingsBuilder(() {
            Get.put(AuthController());
        })),

GetPage(
        name: productPage,
        page: () =>  ProductsScreen(),
        transition: Transition.fadeIn,
        binding: BindingsBuilder(() {
            Get.put(HomeController());
        })),

GetPage(
        name: payPage,
        page: () =>  PaymentInfoScreen(),
        transition: Transition.fadeIn,
        binding: BindingsBuilder(() {
          Get.put(PaymentController());
        })),

    GetPage(
        name: choosePayPage,
        page: () => const ChoosePayScreen(),
        transition: Transition.fadeIn,
        binding: BindingsBuilder(() {
    Get.put(PaymentController());
        })),

        
GetPage(
        name: shoppingPage,
        page: () => const ShoppingScreen(),
        transition: Transition.fadeIn,
        binding: BindingsBuilder(() {
        //Get.put(PaymentController());
        })),


   
  ];

  
    static String splashPage = '/splash';
    
   static String registerPage = '/register';
        static String homePage = '/home';
  static String loginPage = '/login';
  static String forgetPasswordPage = '/forgetPassword';
  static String otpPage = '/otp';
  static String resetPage = '/resetPassword';
  static String payPage = '/payPage';
  static String choosePayPage = '/choosePayPage';
  static String shoppingPage = '/shoppingPage';
  static String productPage = '/productPage';


}
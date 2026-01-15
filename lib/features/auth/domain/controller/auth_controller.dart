import 'dart:async';
import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/data/data_sources/get_storage.dart';
import 'package:ecommerce_app/data/models/auth/login/login_response.dart';
import 'package:ecommerce_app/data/models/auth/login/post_login.dart';
import 'package:ecommerce_app/data/models/auth/otp/post_otp.dart';
import 'package:ecommerce_app/data/models/auth/refreshToken/post_refresh_token.dart';
import 'package:ecommerce_app/data/models/auth/refreshToken/refresh_token_response.dart';
import 'package:ecommerce_app/data/models/auth/register/post_register.dart';
import 'package:ecommerce_app/data/models/auth/register/register_response.dart';
import 'package:ecommerce_app/data/models/auth/reset_password/post_reset_password.dart';
import 'package:ecommerce_app/data/models/auth/user/user_data.dart';
import 'package:ecommerce_app/data/remote_data/response_model.dart';
import 'package:ecommerce_app/domain_data/custom_mixin/custom_state_mixin.dart';
import 'package:ecommerce_app/features/auth/domain/cases/auth_case.dart';
import 'package:ecommerce_app/features/home/domain/controller/home_controller.dart';
import 'package:ecommerce_app/res/router/pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class AuthController extends MainGetxController with CustomStateMixin {
 
   final hidePassword1 = true.obs;
   final hidePassword2 = true.obs;
   final hidePassword3 = true.obs;
   final hidePassword4 = true.obs;

  TextEditingController emailController1 = TextEditingController();
  TextEditingController emailController2 = TextEditingController();
  TextEditingController emailController3 = TextEditingController();
  TextEditingController emailController4 = TextEditingController();

  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController passwordController4 = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();
  final registerFormKey2 = GlobalKey<FormState>();
  final forgetPasswordFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();

  PostRegister postRegister = PostRegister();
  RegisterResponse postRegisterResponse = RegisterResponse();

  PostLogin postLogin = PostLogin();
  LoginResponse loginResponse = LoginResponse();

  clearData() {
    postRegister = PostRegister();
  }

  UserData loginModel = UserData();

  // register() async {
  //   sPrint.info('register');
  //   loadingGetxController.showLoading();
  //   var response = await sl<AuthCases>().register(postRegister);
  //   sPrint.info("responseeeeeeeeeeeeeeee  ${response}");
  //   loadingGetxController.hideLoading();
  //   statusError.checkStatus(
  //     response,
  //     () {
  //       loginModel = response as UserData;
  //       sPrint.info('login data:: ${loginModel.toJson()}');
  //       print("User name: ${loginModel.fullName}");
  //       sl<AuthCases>().setUser(loginModel);
  //       print("id: ${loginModel.userId }");

  //       Get.offAllNamed(CustomPage.homePage);
  //       /*   sPrint.info('getting success login');
  //     Get.put(OTPController()).startCount();
  //     Get.to(() => OtpConfirmationView(
  //         getCode: (code) => getCode(code), resendCode: resendOTP));*/
  //     },
  //     onError: (msg) {
  //       Get.snackbar("خطأ", msg ?? "فشل إنشاء الحساب");
  //     },
  //   );
  // }

  register() async {
    loadingGetxController.showLoading();

    try {
      var response = await sl<AuthCases>().register(postRegister);
      loadingGetxController.hideLoading();

      if (response.status == 1) {
        // ✅ السيرفر بيرجع فقط رسالة بدون بيانات user

        Get.snackbar(
          "نجاح",
          response.message ?? "تم إرسال OTP بنجاح",
        );
        print('register response message:dd ${response.message}');

        if (response.data == null) {
          print('register response message:dd ${response.message}');

        } else {
          loginModel = response.data!;
          Get.snackbar(
            "نجاح",
            response.message ?? "تم إرسال OTP بنجاح",
          );
          print('register response message:dd ${response.message}');
Get.offAllNamed(CustomPage.otpPage);
        }
      } else if (response.errors != null && response.errors!.isNotEmpty) {
        String errorMessages = response.errors!.values
            .map((e) => e is List ? e.join('\n') : e.toString())
            .join('\n');
        Get.snackbar("⚠️ أخطاء في البيانات", errorMessages);
      } else {
        Get.snackbar("خطأ", response.message ?? "فشل إنشاء الحساب");
      }
    } catch (e) {
      loadingGetxController.hideLoading();
      Get.snackbar("خطأ", "تعذر الاتصال بالسيرفر");
    }
  }
LoginResponse loginResponsee = LoginResponse();

login() async {
  sPrint.info('login');
  loadingGetxController.showLoading();
  // postLogin.email = "m22090121@gmail.com";
  // postLogin.password = "Man0.0ham";
  var response = await sl<AuthCases>().login(postLogin);
  loadingGetxController.hideLoading();

  statusError.checkStatus(
    response,
    () async {
       loginResponsee = response.data; // this is LoginResponse
      sPrint.info('response data:: ${response.toJson()}');

      final accessToken = loginResponsee.accessToken;
      final refreshToken = loginResponsee.refreshToken;
      if (accessToken != null && accessToken.isNotEmpty && refreshToken != null && refreshToken.isNotEmpty) {
        await sl<GetStorageData>().setToken(accessToken , refreshToken);
        sl<AuthCases>().setUser(loginModel);

        sPrint.success("✅ Token saved: $accessToken");
        // await sl<GetStorageData>().getToken();
      } else {
        sPrint.warning("⚠️ No token found in login response");
      }
   final homeController = Get.find<HomeController>();
    await Future.wait(
                  [
                    homeController.getAllCategories(),
                    homeController.getAllProducts(),
                    getUserInfo(),
                  ],
                );
      Get.offAllNamed(CustomPage.homePage);
          
    },
    onError: (msg) {
      print("nn");
      Get.snackbar("خطأ", msg ?? "فشل تسجيل الدخول");
    },
  );
}

PostRefreshToken postRefreshToken = PostRefreshToken();
RefreshTokenResponse refreshTokenResponse = RefreshTokenResponse();
Future<bool> refreshToken() async {
  try {
    final refreshToken = await sl<GetStorageData>().getRefreshToken();
    if (refreshToken == null) return false;

    postRefreshToken.refreshToken = refreshToken;

    final response = await sl<AuthCases>().refreshToken(postRefreshToken);
refreshTokenResponse = response.data!;
    if (response.data != null) {
      await sl<GetStorageData>().setToken(
        response.data!.accessToken!,
        response.data!.refreshToken!,
      );
      return true;
    }
    return false;
  } catch (e) {
    return false;
  }
}



Future<bool> tryAutoLogin() async {
  return await refreshToken();
}




  loginm() async {
    sPrint.info('login');
    loadingGetxController.showLoading();
    var response = await sl<AuthCases>().login(postLogin);
    loadingGetxController.hideLoading();
    statusError.checkStatus(
      response,
      () {
        loginModel = response.data! ;
        sPrint.info('response data:: ${response.toJson()}');
        sPrint.info('login data:: ${loginModel.toJson()}');
        sl<AuthCases>().setUser(loginModel);

        Get.offAllNamed(CustomPage.homePage);
      },
      onError: (msg) {
        Get.snackbar("خطأ", msg ?? "فشل تسجيل الدخول");
      },
    );
  }

  var isZero = false.obs;
  int counter = 30;
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    startCount();
  }

 @override
void onClose() {
  timer.cancel();
  super.onClose();
}

  String otp = "";

  void startCount() {
    isZero.value = false;
    counter = 30;
    
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter > 0) {
        counter--;
      }
      if (counter == 0) {
        isZero.value = true;
        timer.cancel();
      }
      update();
    });
  }

  PostOtp postOtp = PostOtp();
  verifyOTP(postOtp) async {
    loadingGetxController.showLoading();
    var response = await sl<AuthCases>().verifyOTP(postOtp);
    loadingGetxController.hideLoading();
    statusError.checkStatus(response, () {
      loginModel = response as UserData;
      sl<AuthCases>().setUser(loginModel);
      // Get.off(() => ResetPasswordScreen(), transition: Transition.fadeIn);
    });
  }



  var isResending = false.obs;

resendOTP(String email) async {
  try {
    isResending.value = true; 
    var response = await sl<AuthCases>().resendOTP(email);

    statusError.checkStatus(response, () {
      Get.snackbar(
        "Success",
        response.message ?? "OTP sent successfully",
      );
    });
  } catch (e) {
    Get.snackbar("Error", "Failed to resend OTP");
  } finally {
    isResending.value = false; // ✅ ينتهي التحميل
  }
}



  forgetPassword(String email) async {
    loadingGetxController.showLoading();
    var response = await sl<AuthCases>().forgetPassword(email);
    loadingGetxController.hideLoading();
    statusError.checkStatus(response, () {
       Get.snackbar(
        "Success",
        response.message ?? "OTP sent successfully",
      );
       Get.off(() => CustomPage.resetPage, transition: Transition.fadeIn);
    });
  }


PostResetPassword data = PostResetPassword();

  resetPassword(data) async {
    loadingGetxController.showLoading();
    var response = await sl<AuthCases>().resetPassword(data);
    loadingGetxController.hideLoading();
    statusError.checkStatus(response, () {
       Get.snackbar(
        "Success",
        response.message ?? "password changedd successfully",
      );
       Get.off(() => CustomPage.loginPage, transition: Transition.fadeIn);
    });
  }


int _page = 1;
RefreshController refreshController = RefreshController();
  onRefresh() async {
  final response = await refreshData<ResponseModel<UserData?>>(
    model: ResponseModel<UserData?>(data: loginModel),
    futureMethod: () => sl<AuthCases>().userInfo(),
    controller: refreshController,
    checkIfEmpty: (currentResponse) {
      final user = currentResponse.data;
      if (user != null && (user.fullName ?? '').isNotEmpty) {
        return currentResponse; // Valid → use new data
      }
      return ResponseModel<UserData?>(data: loginModel); // Invalid → keep old data wrapped
    },
    getPage: (page) => _page = page,
  );

  if (response != null) {
    loginModel = response.data ?? loginModel;
  }
}


//Future<ResponseModel<UserData?>> get u async => await sl<AuthCases>().userInfo();

String? name;
String? email;

Future<void> getUserInfo() async {
  if( loginModel.fullName != null && loginModel.email != null){
    return;
  }
  loadingGetxController.showLoading();

  String? token =  sl<GetStorageData>().getToken();
  print("📘 Token: $token");

  final response = await sl<AuthCases>().userInfo();
  //loadingGetxController.hideLoading();

  print("📙 ResponseModel data: ${response.toJson()}");
name=response.data?.fullName.toString();
email=response.data?.email.toString();

print("${response} }");
  if (response.data != null) {
    loginModel = response.data!;
    print("jjjjjj ${response.data?.fullName.toString()}");
print("📘 User Info: ${loginModel.toJson()}");
print(" User Info:ggg ${loginModel.email} , ${loginModel.fullName} ");

    print("✅ loginModel after refresh: ${loginModel.toJson()}");
  } else {
    print("❌ Failed to load user info: ${response.message}");
  }
  update();
}


// String? get userName   {
//  final res=   getUserInfo();
//  final n = res.fullName.toString();
//   return n;

// }

}

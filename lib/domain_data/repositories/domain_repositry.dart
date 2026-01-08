

import 'package:ecommerce_app/data/models/auth/login/post_login.dart';
import 'package:ecommerce_app/data/models/auth/otp/post_otp.dart';
import 'package:ecommerce_app/data/models/auth/refreshToken/post_refresh_token.dart';
import 'package:ecommerce_app/data/models/auth/refreshToken/refresh_token_response.dart';
import 'package:ecommerce_app/data/models/auth/register/post_register.dart';
import 'package:ecommerce_app/data/models/auth/reset_password/post_reset_password.dart';
import 'package:ecommerce_app/data/models/auth/user/user_data.dart';
import 'package:ecommerce_app/data/models/auth/users/UsersModel.dart';
import 'package:ecommerce_app/data/models/auth/users/post_assign_user.dart';
import 'package:ecommerce_app/data/models/categories/get/all_categories.dart';
import 'package:ecommerce_app/data/models/payment/kiosk_payment_response.dart';
import 'package:ecommerce_app/data/models/payment/payment_token/auth_token/auth_token_response.dart';
import 'package:ecommerce_app/data/models/payment/payment_token/auth_token/post_api_key.dart';
import 'package:ecommerce_app/data/models/payment/payment_token/final_token/final_token_response.dart';
import 'package:ecommerce_app/data/models/payment/payment_token/final_token/post_final_token.dart';
import 'package:ecommerce_app/data/models/payment/payment_token/order_id/order_id_response.dart';
import 'package:ecommerce_app/data/models/payment/payment_token/order_id/post_order_id.dart';
import 'package:ecommerce_app/data/models/payment/post_kiosk_payment.dart';
import 'package:ecommerce_app/data/models/products/get/all_products.dart';
import 'package:ecommerce_app/data/remote_data/response_model.dart';


abstract class DomainData {
  /*
  * this is abstract class to connect your features with data package
  * it will contain methods of all project
  * need to add comment for name of features for all it's methods
  * example::
  * // login feature
  * => loginMethod();
  * => another method();
   */

  // login feature

  // firebase
// Future<bool> checkFirebase();

  // api

/*
  * this is abstract class to connect your features with data package
  * it will contain methods of all project
  * need to add comment for name of features for all it's methods
  * example::
  * // login feature
  * => loginMethod();
  * => another method();
   */

  // login feature

  // api

//  Future<dynamic> login(String phone, String password);


  ///----------------------------------- team -----------------------------

  // get storage

  UserData? getUser();

  setUser(UserData? UserData);

  setToken(String? token ,String? refreshToken  );
String?getToken();
String?getRefreshToken();
void deleteToken();


//   setPaymentToken(String? token);
// Future<String?> getPaymentToken();
  
  //Future<ResponseModel<dynamic>> getCode(String phone);

  Future<ResponseModel> register(PostRegister register);
  
  Future<ResponseModel> login(PostLogin login);

  Future<ResponseModel<RefreshTokenResponse>> refreshToken(PostRefreshToken refreshToken);

  Future<ResponseModel<UserData?>> verifyOTP(PostOtp otp);

 // Future<ResponseModel<dynamic>> resetPassword({required String password});
 
  Future<ResponseModel<UserData?>> resendOTP(String email);

  Future<ResponseModel<dynamic>> forgetPassword(String email);

  Future<ResponseModel<dynamic>> resetPassword(PostResetPassword data);

  Future<ResponseModel<UserData?>> userInfo();

  Future<ResponseModel<List<AllCategories>?>> allCategories();

  Future<ResponseModel<List<AllProducts>?>> allProducts();

  Future<ResponseModel<ResponseApiKey?>> authToken(PostApiKey authToken);

  Future<ResponseModel<ResponseOrderId?>> orderId(PostOrderId postOrderId);

  Future<ResponseModel<ResponseFinalToken?>> paymentToken(PostFinalToken postFinalToken);

  Future<void> setPaymentToken(String? token);

  String? getPaymentToken();

  Future<ResponseModel<KioskPaymentResponse?>> kioskPayment(PostPaymentKiosk postPaymentKiosk);




}


import 'package:ecommerce_app/data/models/auth/login/post_login.dart';
import 'package:ecommerce_app/data/models/auth/otp/post_otp.dart';
import 'package:ecommerce_app/data/models/auth/refreshToken/post_refresh_token.dart';
import 'package:ecommerce_app/data/models/auth/refreshToken/refresh_token_response.dart';
import 'package:ecommerce_app/data/models/auth/register/post_register.dart';
import 'package:ecommerce_app/data/models/auth/reset_password/post_reset_password.dart';
import 'package:ecommerce_app/data/models/auth/user/user_data.dart';
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
import '../../domain_data/repositories/domain_repositry.dart';
import '../data_sources/get_storage.dart';
import '../remote_data/remote.dart';

class DataRepository implements DomainData {
  GetStorageData storage;

  // RemoteFire remoteFire;
  Remote remote;

  DataRepository({
    required this.storage,
    required this.remote,
    //  required this.remoteFire,
  });

  @override
  UserData? getUser() {
   return storage.getUser();
  }

  @override
  setUser(UserData? UserData) {
    return storage.setUser(UserData);
  }



  @override
  setToken(String? token , String? refreshToken) {
    return storage.setToken(token! , refreshToken! );
  }
  
  @override
 String?getToken() {
   return storage.getToken();
  }

  @override
  String? getRefreshToken() {
    return storage.getRefreshToken();
  }

  @override
  deleteToken() {
    return storage.deleteToken();
  }
  


  @override
  Future<ResponseModel> register(PostRegister register) {
    return remote.register(register);
  }


 @override
  Future<ResponseModel> login(PostLogin login) {
    return remote.login(login);
  }


  @override
  Future<ResponseModel<UserData?>> verifyOTP(PostOtp otp) {
    return remote.verifyOTP(otp);
  }
  
  @override
  Future<ResponseModel<UserData?>> resendOTP(String email) {
   return remote.resendOTP(email);
  }
  
  @override
  Future<ResponseModel> forgetPassword(String email) {
    return remote.forgetPassword(email);
  }

  @override
  Future<ResponseModel> resetPassword(PostResetPassword data) {
    return remote.resetPassword(data);
  }
  
  @override
  Future<ResponseModel<UserData?>> userInfo() {
    return remote.userInfo();
  }

  @override
  Future<ResponseModel<List<AllCategories>>> allCategories() {
       return remote.allCategories();

  }

  @override
  Future<ResponseModel<List<AllProducts>?>> allProducts() {
    return remote.allProducts();
  }

  @override
  Future<ResponseModel<ResponseApiKey?>> authToken(PostApiKey authToken) {
    return remote.authToken(authToken);
  }
  
  @override
  
  
    Future<void>  setPaymentToken(String? token) {
    return storage.setPaymentToken(token!);
  }
  
  @override
  String? getPaymentToken() {
    return storage.getPaymentToken();
  }

  @override
  Future<ResponseModel<ResponseOrderId?>> orderId(PostOrderId postOrderId) {
    return remote.orderId(postOrderId);
  }

  @override
  Future<ResponseModel<ResponseFinalToken?>> paymentToken(PostFinalToken postFinalToken) {
   return remote.paymentToken(postFinalToken);
  }

  @override
  Future<ResponseModel<KioskPaymentResponse?>> kioskPayment(PostPaymentKiosk postPaymentKiosk) {
    return remote.kioskPayment(postPaymentKiosk);
  }

  @override
  Future<ResponseModel<RefreshTokenResponse>> refreshToken(PostRefreshToken refreshToken) {
    return remote.refreshToken(refreshToken);
  }


  // @override
  // Future<ResponseModel<void>> signOut(PostLogout logout) {
  //   return remote.signOut(logout);
  // }



  // @override
  // Future<ResponseModel> resetPassword({required String password}) {
  //   return remote.resetPassord(password: password);
  // }

}


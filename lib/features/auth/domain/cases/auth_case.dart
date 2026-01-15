import 'dart:io';
import 'package:ecommerce_app/data/models/auth/login/post_login.dart';
import 'package:ecommerce_app/data/models/auth/otp/post_otp.dart';
import 'package:ecommerce_app/data/models/auth/refreshToken/post_refresh_token.dart';
import 'package:ecommerce_app/data/models/auth/refreshToken/refresh_token_response.dart';
import 'package:ecommerce_app/data/models/auth/register/post_register.dart';
import 'package:ecommerce_app/data/models/auth/reset_password/post_reset_password.dart';
import 'package:ecommerce_app/data/models/auth/user/user_data.dart';
import 'package:ecommerce_app/data/remote_data/response_model.dart';
import 'package:ecommerce_app/domain_data/repositories/domain_repositry.dart';

class AuthCases {
  final DomainData _data;

  AuthCases(this._data);

  UserData? getUser() {
    
    return _data.getUser();
  }

  setUser(UserData? loginModel) {
    return _data.setUser(loginModel);
    
  }

   String? getToken() {
    return _data.getToken();
  }

  setToken(String? token , String? refreshToken) {
    return _data.setToken(token , refreshToken);
    
  }


  Future<dynamic> register(PostRegister register) {
    return _data.register(register);
  }

  Future<dynamic> login(PostLogin login) {
    return _data.login(login);
  }

Future<ResponseModel<RefreshTokenResponse>> refreshToken(PostRefreshToken refreshToken)  {
    return _data.refreshToken(refreshToken);
  }

 Future<ResponseModel<UserData?>> verifyOTP(PostOtp otp) {
    return _data.verifyOTP(otp);
  }


Future<ResponseModel<UserData?>> resendOTP(String email) {
    return _data.resendOTP(email);
  }

Future<ResponseModel<dynamic>> forgetPassword(String email) {
    return _data.forgetPassword(email);
  }

Future<ResponseModel<dynamic>> resetPassword(PostResetPassword data) {
    return _data.resetPassword(data);
  }

  Future<ResponseModel<UserData?>> userInfo() {
    return _data.userInfo();
  }

  
  // Future<ResponseModel<void>> signOut(PostLogout logout) {
  //   return _data.signOut(logout);
  // }

  // Future<ResponseModel<dynamic>> getCode(String text) {
  //   return _data.getCode(text);
  // }

 

  // Future<ResponseModel<dynamic>> resetPassord({required String password}) {
  //   return _data.resetPassword(password: password);
  // }

  // Future<ResponseModel<String?>> uploadProfileImage(File file) {
  //   return _data.uploadProfileImage(file);
  // }

  // Future<ResponseModel<LoginData?>> editProfile(PostEditProfile profile) {
  //   return _data.editProfile(profile);
  // }

  // Future<ResponseModel> register(PostRegister register) {
  //   return _data.register(register);
  // }

  // Future<ResponseModel<LoginData?>> socialLogin(SocialModel? socialModel) {
  //   return _data.socialLogin(socialModel);
  // }


  // Future<ResponseModel<User?>> getUserData() {
  //   return _data.getUserData();
  // }
  
}

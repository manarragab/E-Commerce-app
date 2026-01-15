import 'package:ecommerce_app/data/models/auth/login/login_response.dart';
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
import 'package:ecommerce_app/res/configuration/print_types.dart';

import 'dio_helper.dart';

class Remote {
  final DioHelper _helper;

  Remote(this._helper);

  // feature authenticate

 /* Future<ResponseModel> login(String text, String password) async {
    sPrint.info('get data');
    bool isPhoneNumber = GetUtils.isPhoneNumber(text);
    Map<String, dynamic> json = {
      'email': text,
      'password': password,
      'device_token': await PushNotificationsManager().getNotificationToken()
    };
    // return Future.delayed(const Duration(seconds: 1), () {
    //   return LoginModel();
    // });

    return _helper.post<LoginData?>(
      json,
      path: '/user/login',
      onSuccess: (Map<String, dynamic> data) {
        sPrint.success(data);
        sPrint.info('getting data:: $data');
        // var response =  LoginModel.fromJson(data["data"]);
        // sPrint.info('login:: ${response.toJson()}');
        // return response;
        return LoginModel.fromJson(data);
      },
      onError: (data) {
        sPrint.warning('error  ${data.data?.status}:: ${data.message}');
        return ResponseModel(status: 0, message: "${data.message}");
      },
      useFormData: true,
      isLogin: false,
    );
  }*/



// Future<ResponseModel> register(PostRegister register) async {
//   print('registering user with data: ${register.toJson()}');
//     return _helper.post<UserData>(
//       await register.toJson(),
//       path: '/auth/register',
//       onSuccess: (Map<String, dynamic> data) {
//         sPrint.success(data);
//         sPrint.info('getting data:: $data');
//         final loginModel = UserData.fromJson(data);
//         sPrint.info('register data from remote:: ${loginModel.toJson()}');
//         return ResponseModel<UserData>(status: 1, message: "success", data: loginModel);
//       },
//       onError: (data) {
//         sPrint.warning('error  ${data.data?.status}:: ${data.message}');
//         return ResponseModel(status: 0, message: "${data.message}");
//       },
//       useFormData: false,
//       isLogin: false,
//     );
//   }


Future<ResponseModel> register(PostRegister register) async {
  print('registering user with data: ${register.toJson()}');

  return _helper.post<UserData>(
    await register.toJson(),
    path: '/auth/register',
    onSuccess: (Map<String, dynamic> data) {
      sPrint.success(data);
      final loginModel = UserData.fromJson(data);
      return ResponseModel<UserData>(
        status: 1,
        message:"success , otp sent to email ",
        data: loginModel,
      );
    },
    onError: (data) {
      sPrint.warning('error ${data.data} :: ${data.message}');
      return ResponseModel(
        status: 0,
        message: data.message ?? 'Unknown error',
        errors: data.data, 
      );
    },
    useFormData: false,
    isLogin: false,
  );
}

Future<ResponseModel<LoginResponse>> login(PostLogin login) async {
  return _helper.post(
    await login.toJson(),
    path: '/auth/login',
    onSuccess: (Map<String, dynamic> data) {
      sPrint.success(data);
      sPrint.info('getting data:: $data');
      final loginResponse = LoginResponse.fromJson(data);
      return ResponseModel<LoginResponse>(
        status: 1,
        message: "success",
        data: loginResponse,
      );
    },
    onError: (data) {
      sPrint.warning('errorrrr ${data.data?.status}:: ${data.message}');
      return ResponseModel(status: 0, message: "${data.message}");
    },
    useFormData: false,
isLogin: false
  );
}



Future<ResponseModel<RefreshTokenResponse>> refreshToken(PostRefreshToken refreshToken) async {
  return _helper.post(
    await refreshToken.toJson(),
    path: '/auth/refresh-token',
    onSuccess: (Map<String, dynamic> data) {
      sPrint.success(data);
      sPrint.info('getting data:: $data');
      final refreshTokenResponse = RefreshTokenResponse.fromJson(data);
      sPrint.info('login data from remote:: ${refreshTokenResponse.toJson()}');
      return ResponseModel<RefreshTokenResponse>(
        status: 1,
        message: "success",
        data: refreshTokenResponse,
      );
    },
    onError: (data) {
      sPrint.warning('errorrrr ${data.data?.status}:: ${data.message}');
      return ResponseModel(status: 0, message: "${data.message}");
    },
    useFormData: false,
    isLogin: true
  );
}


  Future<ResponseModel<UserData?>> verifyOTP(PostOtp otp) async {
    return _helper.post<UserData?>(
      otp.toJson()  
      , path: "/auth/validate-otp", onSuccess: (dynamic data) {
        print('otp response data: $data');
      return ResponseModel<UserData?>(
        status: 1,
        message: "success",
        data: UserData.fromJson(data),
      );
    }, onError: (data) {
      return ResponseModel(status: data.status, message: data.message);
    }, useFormData: false);
  }

Future<ResponseModel<UserData?>> resendOTP(String email) async {
  return _helper.post<UserData?>(
    {"email": email},
    path: "/auth/resend-otp",
    onSuccess: (dynamic data) {
      print('resend otp response data: $data');
      return ResponseModel<UserData?>(
        status: 1,
        message: data is String ? data : "OTP sent successfully",
        data: null,
      );
    },
    onError: (data) {
      return ResponseModel(
        status: data.status,
        message: data.message,
      );
    },
    useFormData: false,
  );
}


  Future<ResponseModel<dynamic>> forgetPassword(String email, 
      ) async {
    return _helper.post<dynamic>(
      {
        "email": email,
      },
      path: "/auth/forgot-password",
      onSuccess: (dynamic data) {
        return ResponseModel<dynamic>(
        status: 1,
        message: data is String ? data : "OTP sent successfully",
        data: null,
      );
      },
      onError: (data) {
        return ResponseModel(status: data.status, message: data.message);
      },
      useFormData: false,
      isLogin: false,
    );
  }


  Future<ResponseModel<dynamic>> resetPassword(
      PostResetPassword data) async {
    return _helper.post<dynamic>(
      data.toJson(),
      path: "/auth/reset-password",
      onSuccess: (dynamic data) {
     return ResponseModel<dynamic>(
        status: 1,
        message: data is String ? data : "password changed successfully",
        data: null,
      );     
       },
      onError: (data) {
        return ResponseModel(status: data.status, message: data.message);
      },
      useFormData: false,
      isLogin: false,
    );
  }


// Future<ResponseModel<UserData?>> userInfo() async {
//   return _helper.get<UserData?>(
//     {},
//     path: "/auth/me",
//     onSuccess: (data) {
//       print('get user info response data: $data');
//       return ResponseModel<UserData?>(
//         status: data['status'] ?? 1,
//         message: data['message'] ?? "Success",
//         data: UserData.fromJson(data), 
//       );
//     },
//     onError: (data) {
//       return ResponseModel(
//         status: data.status,
//         message: data.message,
//       );
//     },
//     isLogin: true,
//   );
// }

Future<ResponseModel<UserData?>> userInfo() async {
  return _helper.get<UserData?>(
    {},
    path: "/auth/me",
    onSuccess: (dynamic data) {
      return ResponseModel<UserData?>(
        status: data['status'] ?? 0,
        message: data['message'] ?? "",
        data: data['data'] != null
            ? UserData.fromJson(data['data'])
            : null,
      );
    },
    onError: (data) {
      return ResponseModel<UserData?>(
        status: data.status ?? 0,
        message: data.message ?? "",
        data: null,
      );
    },
    isLogin: true,
  );
}


//https://fakestoreapi.com/products

Future<ResponseModel<List<AllCategories>>> allCategories() async {
  return _helper.get(
    {},
    path: "https://api.escuelajs.co/api/v1/categories",
    onSuccess: (data) {
      print('get categories response: $data');

      // List<AllCategories> list =
      //     (data as List).map((e) => AllCategories.fromJson(e)).toList();

  final List list = data['data'] as List;

      final categories =
          list.map((e) => AllCategories.fromJson(e)).toList();

      return ResponseModel(
        status: data['status'] ?? 1,
        message: data['message'] ?? "Success",
        data: categories,
      );

    },
    onError: (data) {
      return ResponseModel(
        status: data.status,
        message: data.message,
        data: null,
      );
    },
    isLogin: true
  );
}

Future<ResponseModel<List<AllProducts>>> allProducts() async {
  return _helper.get(
    {},
    path: "https://api.escuelajs.co/api/v1/products",
    onSuccess: (data) {
      print('get categories response data: $data');

      List<AllProducts> list =
          (data['data'] as List).map((e) => AllProducts.fromJson(e)).toList();

      return ResponseModel(
        status: data['status'] ?? 1,
        message: data['message'] ?? "Success",
        data: list,
      );
    },
    onError: (data) {
      return ResponseModel(
        status: data.status,
        message: data.message,
        data: null,
      );
    },
    isLogin: true
  );
}


//payment
//1- get auth token
 Future<ResponseModel<ResponseApiKey?>> authToken(PostApiKey authToken) async {
    return _helper.post<ResponseApiKey?>(
      authToken.toJson()  
      , path: "https://accept.paymob.com/api/auth/tokens", onSuccess: (dynamic data) {
        print('auth token data: $data');
      return ResponseModel<ResponseApiKey?>(
        status: 1,
        message: "success",
        data: ResponseApiKey.fromJson(data),
      );
    }, onError: (data) {
      return ResponseModel(status: data.status, message: data.message);
    }, useFormData: false);
  }


//2- get order id
 Future<ResponseModel<ResponseOrderId?>> orderId(PostOrderId postOrderId  ) async {
    return _helper.post<ResponseOrderId?>(
      postOrderId.toJson()  
      , path: "https://accept.paymob.com/api/ecommerce/orders", onSuccess: (dynamic data) {
        print('order id data: $data');
      return ResponseModel<ResponseOrderId?>(
        status: 1,
        message: "success",
        data: ResponseOrderId.fromJson(data),
      );
    }, onError: (data) {
      return ResponseModel(status: data.status, message: data.message);
    }, useFormData: false);
  }

//final token 
   Future<ResponseModel<ResponseFinalToken?>> paymentToken(PostFinalToken postFinalToken) async {
    return _helper.post<ResponseFinalToken?>(
      postFinalToken.toJson()  
      , path: "https://accept.paymob.com/api/acceptance/payment_keys", onSuccess: (dynamic data) {
        print('final token data: $data');
      return ResponseModel<ResponseFinalToken?>(
        status: 1,
        message: "success",
        data: ResponseFinalToken.fromJson(data),
      );
    }, onError: (data) {
      return ResponseModel(status: data.status, message: data.message);
    }, useFormData: false);
  }

//visa payment => is google link

//kiosk payment
   Future<ResponseModel<KioskPaymentResponse?>> kioskPayment(PostPaymentKiosk postPaymentKiosk  ) async {
    return _helper.post<KioskPaymentResponse?>(
      postPaymentKiosk.toJson()  
      , path: "https://accept.paymob.com/api/acceptance/payments/pay", onSuccess: (dynamic data) {
        print('final reference code data: $data');
      return ResponseModel<KioskPaymentResponse?>(
        status: 1,
        message: "success",
        data: KioskPaymentResponse.fromJson(data),
      );
    }, onError: (data) {
      return ResponseModel(status: data.status, message: data.message);
    }, useFormData: false);
  }







  // Future<ResponseModel<dynamic>> getCode(String text) async {
  //   Map<String, dynamic> json = {
  //     'identifier': text,
  //   };

  //   sPrint.info(json);

  //   // return Future.delayed(const Duration(seconds: 1), () {
  //   //   return LoginModel();
  //   // });

  //   return _helper.post<dynamic>(json, path: '/user/forget-password',
  //       onSuccess: (Map<String, dynamic> data) {
  //     return ResponseModel.fromJson(data);
  //   }, onError: (data) {
  //     return ResponseModel(status: data.status, message: data.message);
  //   }, useFormData: false);
  // }

  // Future<ResponseModel<LoginData?>> checkCode(String code, String email) async {
  //   return _helper.post<LoginData?>({
  //     "otp": code,
  //     "email": email,
  //   }, path: "/user/verify-otp", onSuccess: (dynamic data) {
  //     return LoginModel.fromJson(data);
  //   }, onError: (data) {
  //     return ResponseModel(status: data.status, message: data.message);
  //   }, useFormData: true);
  // }

  // Future<ResponseModel<dynamic>> resetPassord(
  //     {required String password}) async {
  //   return _helper.post<dynamic>(
  //     {
  //       "password": password,
  //       "password_confirmation": password,
  //     },
  //     path: "/user/reset-password",
  //     onSuccess: (dynamic data) {
  //       return ResponseModel.fromJson(data);
  //     },
  //     onError: (data) {
  //       return ResponseModel(status: data.status, message: data.message);
  //     },
  //     useFormData: false,
  //     isLogin: true,
  //   );
  // }







}

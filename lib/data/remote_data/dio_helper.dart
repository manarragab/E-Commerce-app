import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/data/data_sources/get_storage.dart';
import 'package:ecommerce_app/data/models/auth/login/login_response.dart';
import 'package:ecommerce_app/data/models/auth/refreshToken/post_refresh_token.dart';
import 'package:ecommerce_app/data/remote_data/remote.dart';
import 'package:ecommerce_app/data/remote_data/response_model.dart';
import 'package:ecommerce_app/domain_data/custom_mixin/mixen_widgets/status_error.dart';
import 'package:ecommerce_app/localization/change_language.dart';
import 'package:ecommerce_app/res/configuration/print_types.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/res/injection.dart';
import 'package:ecommerce_app/res/router/pages.dart';
import 'package:get/get.dart' as g;
import 'package:get/utils.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../domain_data/main_getx_controller/main_getx_controller.dart';
import '../../error/dio_exception.dart';
import '../const/export.dart' show WidgetsBinding;
import 'core.dart';

const String MSG = "message";
const String STATUS = 'status';
const String CODE = 'code';
const String NEED_LOGIN = 'needLogin';
const String PHONE = 'phone';

class DioHelper {
  late Response _response;
  static late final Dio _dio;

  static DioHelper init() {
    _dio = Dio();
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
        _dio.interceptors.add(InterceptorsWrapper(
  onError: (DioException e, handler) async {
    if (e.type == DioExceptionType.connectionTimeout) {
      // إعادة المحاولة مرة تانية
      return handler.resolve(await _dio.fetch(e.requestOptions));
    }
    return handler.next(e);
  },
));

    return DioHelper();
    
  }


// static DioHelper init() {
//   _dio = Dio(
//     // BaseOptions(
//     //   baseUrl: baseUrl, // حطيه لو مش موجود
//     //   receiveDataWhenStatusError: true,
//     //   validateStatus: (status) {
//     //     return status != null && status < 500;
//     //   },
//     //   headers: {
//     //     'Accept': 'application/json',
//     //   },
//     // ),
//   );

//   // Auth + Error Interceptor

//   _dio.interceptors.add(
//     InterceptorsWrapper(
//       onRequest: (options, handler) async {
         
//         final token = sl<GetStorageData>().getToken();
//         if (token != null && token.isNotEmpty) {
//           options.headers['Authorization'] = 'Bearer $token';
//         }
//         return handler.next(options);
//       },
//       onError: (DioException e, handler) async {
//         // 401 Unauthorized
//         if (e.response?.statusCode == 401) {
//           sl<GetStorageData>().deleteToken();
          
//          // Get.offAllNamed(CustomPage.loginPage);
//           return handler.resolve(e.response!);
//         }

//         // Timeout retry (مرة واحدة بس)
//         if (e.type == DioExceptionType.connectionTimeout) {
//           return handler.resolve(await _dio.fetch(e.requestOptions));
//         }

//         return handler.next(e);
//       },
//     ),
//   );

//   return DioHelper();
// }


LoginResponse response = LoginResponse();
 // String? get token => response.accessToken;
  String? get token => sl<GetStorageData>().getToken()?.trim();

//   Future<bool> checkLogin(bool isLogin) async {
//   try {
//     if (isLogin) {
//       if (token != null  && token!.isNotEmpty) {
//         print(" tokennnnnnnnnn=>${token}");
//         return true;
//       } else {
        
//         sPrint.warning('⚠️ No token found — user not authenticated');
//         return false; 
//       }
//     }
//     return true; // If isLogin is false, we don't need authentication
//   } catch (e, s) {
//     sPrint.error(e.toString(), s);
//     return false;
//   }
// }




Future<bool> checkLogin(bool isLogin) async {
  try {
    if (isLogin) {
      final currentToken = token;
      
      if (currentToken == null || currentToken.isEmpty) {
        sPrint.warning('⚠️ No token found — user not authenticated');
        
        return false;
      }
      
     else if (isTokenExpired(currentToken)) {
  sPrint.warning('⚠️ Token expired — need to refresh or login again');
  await _handleExpiredToken();
  final newToken = sl<GetStorageData>().getToken();
  return !isTokenExpired(newToken!); 
}
else
      sPrint.info('✅ Token valid: ${currentToken.substring(0, 20)}...');
      return true;
    }
    return true;
  } catch (e, s) {
    sPrint.error(e.toString(), s);
    return false;
  }
}

// bool isTokenExpired(String token) {
//   try {
//     final parts = token.split('.');
//     if (parts.length != 3) return true;
    
//     final payload = parts[1];
//     final normalized = base64Url.normalize(payload);
//     final decoded = utf8.decode(base64Url.decode(normalized));
//     final payloadMap = json.decode(decoded);
    
//     if (payloadMap['exp'] != null) {
//       final expiryDate = DateTime.fromMillisecondsSinceEpoch(
//         payloadMap['exp'] * 1000
//       );
//       return DateTime.now().isAfter(expiryDate);
//     }
//     return true;
//   } catch (e) {
//     sPrint.error('Error checking token expiry: $e' , StackTrace.current);
//     return true;
//   }
// }


bool isTokenExpired(String token) {
  return Jwt.isExpired(token);
}

Future<void> _handleExpiredToken() async {
   sl<GetStorageData>().deleteToken();
  final refreshToken=  sl<GetStorageData>().getRefreshToken();
  PostRefreshToken postRefreshToken = PostRefreshToken();
      postRefreshToken.refreshToken = refreshToken;
                                                               
      final response = await sl<Remote>().refreshToken(postRefreshToken);

      if (response.status == 1 && response.data != null) {
        final data = response.data!;
        
        await sl<GetStorageData>().setToken(data.accessToken!,data.refreshToken!);
      }
}


// Future<ResponseModel<T>> get<T>(Map<String, dynamic> post,
//     {required ResponseModel<T> Function(Map<String, dynamic> data) onSuccess,
//     required ResponseModel<T> Function(ResponseModel) onError,
//     isLogin = false,
//     String path = '',
//     Map<String, dynamic> headers = const {}}) async {
//   try {
//     if (isLogin && !(await checkLogin(isLogin))) {
//       // Only check login if isLogin is true
//       return ResponseModel(status: 2, message: 'need to authenticate');
//     }

//     if (await connectedToNetwork()) {
//       _dio.options.connectTimeout = const Duration(milliseconds: 20000);
//       _dio.options.receiveTimeout = const Duration(milliseconds: 20000);
      
//       sPrint.info('start $post');
//       sPrint.info('link ${path.contains('http') ? path : apiUrl() + path}');

//       // Build headers conditionally
//       final Map<String, dynamic> requestHeaders = {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         "lang": TLang.getCurrentLocale().name,
//         "Accept-Language": TLang.getCurrentLocale().name,
//         ...headers
//       };

//       // Only add Authorization if isLogin is true AND token exists
//       if (isLogin && token != null) {
//         requestHeaders['Authorization'] = 'Bearer $token';
//         sPrint.info('TOKEN BEING SENT: Bearer $token');
//       } else if (isLogin && token == null) {
//         sPrint.warning('⚠️ isLogin=true but token is null!');
//       }

//       _response = await _dio.get(
//         path.contains('http') ? path : apiUrl() + path,
//         queryParameters: post,
//         options: Options(headers: requestHeaders)
//       );

//       sPrint.warning(_response.data);

//       if ((_response.statusCode == 200 || 
//            _response.statusCode == 202 || 
//            _response.statusCode == 201) && 
//           _response.data is! String) {
        
//         Map<String, dynamic> data;
        
//         sPrint.warning('check if there is data:: ${(_response.data as Map<String, dynamic>).containsKey("data")}');
        
//         // If API returned data in a "data" key
//         if ((_response.data as Map<String, dynamic>).containsKey("data")) {
//           data = {"status": 1, "message": "", ..._response.data};
//         } else {
//           // Wrap the response in a "data" key
//           data = {
//             "status": 1,
//             "message": "",
//             "data": _response.data
//           };
//         }
        
//         return onSuccess(data);
//       } else {
//         if (_response.data is String) {
//           return onError(ResponseModel(
//               status: 0, message: "backend response error in Api $path"));
//         }
//         return onError(ResponseModel.fromJson(_response.data));
//       }
//     } else {
//       throw ('internet connection error');
//     }
//   } catch (error, s) {
//     String msg = '';
//     if (error is DioException) {
//       DioExceptions dioExceptions = DioExceptions.fromDioError(error);
//       msg = dioExceptions.message.toString();
//       return onError(dioExceptions.message);
//     } else {
//       sPrint.error(error.toString(), s);
//       msg = error.toString();
//     }
//     sPrint.warning(msg);
//     return ResponseModel(status: 0, message: msg);
//   }
// }




  Future<ResponseModel<T>> get<T>(Map<String, dynamic> post,
      {required ResponseModel<T> Function(Map<String, dynamic> data) onSuccess,
      required ResponseModel<T> Function(ResponseModel) onError,
      isLogin = false,
      String path = '',
      Map<String, dynamic> headers = const {}}) async {
    try {
      if (await checkLogin(isLogin)) {
        if (await connectedToNetwork()) {
          _dio.options.connectTimeout =
              const Duration(milliseconds: 30000); //5s
          _dio.options.receiveTimeout = const Duration(milliseconds: 30000);
          sPrint.info('start $post');
          sPrint.info('link ${path.contains('http') ? path : apiUrl() + path}');
          _response =
              await _dio.get(path.contains('http') ? path : apiUrl() + path,
                  queryParameters: post,
                  options: Options(headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    //  "fcm_token": await PushNotificationsManager().getNotificationToken(),
                    "lang": TLang.getCurrentLocale().name,
                    "Accept-Language": TLang.getCurrentLocale().name,
                    // if (isLogin)
                    'Authorization':'Bearer ${token}',
                    ...headers
                  }));
          sPrint.warning(_response.data);
         if ((_response.statusCode == 200 ||
     _response.statusCode == 201 ||
     _response.statusCode == 202)) {

  final body = _response.data;

  // لو API رجع List
  if (body is List) {
    return onSuccess({
      "status": 1,
      "message": "",
      "data": body,
    });
  }

  // لو API رجع Map
  if (body is Map<String, dynamic>) {
    // لو مفيش key اسمه data بنرجع الـ map زي ما هو
    if (!body.containsKey("data")) {
      return onSuccess({
        "status": 1,
        "message": "",
        "data": body,
      });
    }

    // لو فيه data
    return onSuccess({
      "status": 1,
      ...body,
    });
  }

  // fallback
  return onSuccess({
    "status": 1,
    "message": "",
    "data": body,
  });
}

 else {
            if (_response.data is String) {
              return onError(ResponseModel(
                  status: 0, message: "backend response error in Api $path"));
            }
            return onError(ResponseModel.fromJson(_response.data));
          }
        } else {
          throw ('internet connection error');
        }
      } else {
        return ResponseModel(status: 2, message: 'need to authenticate');
      }
    } catch (error, s) {
      String msg = '';
      if (error is DioException) {
        DioExceptions dioExceptions = DioExceptions.fromDioError(error);
        msg = dioExceptions.message.toString();
        return onError(dioExceptions.message);
      } else {
        sPrint.error(error.toString(), s);
        msg = error.toString();
      }
      sPrint.warning(msg);
      return ResponseModel(status: 0, message: msg);
    }
  }


  // Future<ResponseModel<T>> post<T>(Map<String, dynamic> post,
  //     {required ResponseModel<T> Function(Map<String, dynamic> data) onSuccess,
  //     required ResponseModel<T> Function(ResponseModel) onError,
  //     isLogin = false,
  //     String path = '',
  //     bool useFormData = true,
  //     bool userParamter = false}) async {
  //   try {
  //     if (await checkLogin(isLogin)) {
  //       if (await connectedToNetwork()) {
  //         _dio.options.connectTimeout =
  //             const Duration(milliseconds: 300000); //5s
  //         _dio.options.receiveTimeout = const Duration(milliseconds: 300000);
  //         sPrint.info('start $post');
  //         sPrint.info('link ${path.contains('http') ? path : apiUrl() + path}');
  //         _response =
  //             await _dio.post(path.contains('http') ? path : apiUrl() + path,
  //                 data: useFormData ? FormData.fromMap(post) : post,
  //                 queryParameters: userParamter ? post : null,
  //                 onSendProgress: showProgress,
  //                 options: Options(headers: {
  //                   'Content-Type': 'application/json',
  //                   'Accept': 'application/json',
  //                   //"fcm_token": await PushNotificationsManager().getNotificationToken(),
  //                   "lang": TLang.getCurrentLocale().name,
  //                   "Accept-Language": TLang.getCurrentLocale().name,
  //                   if (isLogin)
  //                     'Authorization': 'Bearer $token'
  //                 }));
  //         sPrint.warning(
  //             "${path.contains('http') ? path : apiUrl() + path} \n${_response.data}");
  //         if ((_response.statusCode == 200 || _response.statusCode == 201) &&
  //             _response.data is! String) {
  //           sPrint.success("response in dio: ${_response.data}");
  //           _response.data['status'] = StatusType.apiSuccess.index;
  //           return onSuccess(_response.data);
  //         } else {
  //           if (_response.data is String) {
  //             return onError(ResponseModel(
  //                 status: 0, message: "backend response error in Api $path"));
  //           }
  //           if (_response.data is String) {
  //             return onError(ResponseModel(
  //                 status: 0, message: "backend response error in Api $path"));
  //           }
  //           return onError(ResponseModel.fromJson(_response.data));
  //         }
  //       } else {
  //         throw ('internet connection error');
  //       }
  //     } else {
  //       return ResponseModel(status: 2, message: 'need to authenticate');
  //     }
  //   } catch (error, s) {
  //     sPrint.info(
  //         'error on link ${path.contains('http') ? path : apiUrl() + path}');
  //     String msg = '';
  //     if (error is DioException) {
  //       DioExceptions dioExceptions = DioExceptions.fromDioError(error);
  //       msg = dioExceptions.message.toString();
  //       sPrint.warning(
  //           'error:: ${dioExceptions.message.status} ::${dioExceptions.message.message}');
  //       return onError(dioExceptions.message);
  //     } else {
  //       sPrint.error(error.toString(), s);
  //       msg = error.toString();
  //     }
  //     sPrint.warning(msg);
  //     return ResponseModel(status: 0, message: msg);
  //   }
  // }





Future<ResponseModel<T>> post<T>(
  Map<String, dynamic> post, {
  required ResponseModel<T> Function(Map<String, dynamic> data) onSuccess,
  required ResponseModel<T> Function(ResponseModel) onError,
  bool isLogin = false,
  String path = '',
  bool useFormData = true,
  bool userParamter = false,
}) async {
  try {
    if (await checkLogin(isLogin)) {
      if (await connectedToNetwork()) {
        _dio.options.connectTimeout = const Duration(milliseconds: 300000);
        _dio.options.receiveTimeout = const Duration(milliseconds: 300000);

        sPrint.info('start $post');
        sPrint.info('link ${path.contains('http') ? path : apiUrl() + path}');

        _response = await _dio.post(
          path.contains('http') ? path : apiUrl() + path,
          data: useFormData ? FormData.fromMap(post) : post,
          queryParameters: userParamter ? post : null,
          onSendProgress: showProgress,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            "lang": TLang.getCurrentLocale().name,
            "Accept-Language": TLang.getCurrentLocale().name,
            if (isLogin) 'Authorization': 'Bearer $token',
          }),
        );

        sPrint.warning(
            "${path.contains('http') ? path : apiUrl() + path} \n${_response.data}");

if (_response.statusCode == 200 || _response.statusCode == 201) {
  if (_response.data is String) {
    sPrint.success("response (String): ${_response.data}");
    return onSuccess({
      "message": _response.data,
      "status": StatusType.apiSuccess.index,
    });
  } else if (_response.data is Map<String, dynamic>) {
    sPrint.success("response in dio: ${_response.data}");
    _response.data['status'] = StatusType.apiSuccess.index;
    return onSuccess(_response.data);
  } else {
    return onSuccess({
      "message": "Success",
      "status": StatusType.apiSuccess.index,
    });
  }
} else {
  return onError(ResponseModel.fromJson({
    "status": 0,
    "message": "backend response error in Api $path",
  }));
}

      } else {
        throw ('internet connection error');
      }
    } else {
      return ResponseModel(status: 2, message: 'need to authenticate');
    }
  } catch (error, s) {
    sPrint.info(
        'error on link ${path.contains('http') ? path : apiUrl() + path}');
    String msg = '';

    if (error is DioException) {
      final response = error.response;
      if (response != null && response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        String message = data['message'] ?? 'Something went wrong';

        // ✅ If backend returns validation errors, extract them all
        if (data['errors'] != null && data['errors'] is Map<String, dynamic>) {
          final errors = data['errors'] as Map<String, dynamic>;
          final detailedMessages = errors.values
              .expand((e) => (e as List).map((msg) => msg.toString()))
              .join('\n');
          message = '$message\n$detailedMessages';
        }

        msg = message;
        sPrint.warning('error:: ${response.statusCode}: $msg');
        return onError(ResponseModel(status: 0, message: msg));
      } else {
        msg = 'Server returned unexpected error';
      }
    } else {
      sPrint.error(error.toString(), s);
      msg = error.toString();
    }

    sPrint.warning(msg);
    return onError(ResponseModel(status: 0, message: msg));
  }
}




  Future<ResponseModel<T>> put<T>(
    Map<String, dynamic> post, {
    required ResponseModel<T> Function(Map<String, dynamic> data) onSuccess,
    required ResponseModel<T> Function(ResponseModel) onError,
    isLogin = false,
    String path = '',
  }) async {
    try {
      if (await checkLogin(isLogin)) {
        if (await connectedToNetwork()) {
          _dio.options.connectTimeout =
              const Duration(milliseconds: 30000); //5s
          _dio.options.receiveTimeout = const Duration(milliseconds: 30000);
          sPrint.info('start $post');
          sPrint.info('link ${path.contains('http') ? path : apiUrl() + path}');
          _response =
              await _dio.request(path.contains('http') ? path : apiUrl() + path,
                  data: post,
                  onSendProgress: showProgress,
                  options: Options(method: 'PUT', headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    //  "fcm_token": await PushNotificationsManager().getNotificationToken(),
                    "lang": TLang.getCurrentLocale().name,
                    "Accept-Language": TLang.getCurrentLocale().name,
                    if (isLogin)
                      'Authorization': 'Bearer $token'
                  }));
          sPrint.warning(_response.data);
          if (_response.data is String) {
            _response.data = jsonDecode(_response.data);
          }
          if (_response.statusCode == 200 && _response.data is! String) {
            sPrint.success("response in dio: ${_response.data}");
            return onSuccess(_response.data);
          } else {
            if (_response.data is String) {
              return onError(ResponseModel(
                  status: 0, message: "backend response error in Api $path"));
            }
            return onError(ResponseModel.fromJson(_response.data));
          }
        } else {
          throw ('internet connection error');
        }
      } else {
        return ResponseModel(status: 2, message: 'need to authenticate');
      }
    } catch (error, s) {
      String msg = '';
      if (error is DioException) {
        DioExceptions dioExceptions = DioExceptions.fromDioError(error);
        msg = dioExceptions.message.toString();
        return onError(dioExceptions.message);
      } else {
        sPrint.error(error.toString(), s);
        msg = error.toString();
      }
      sPrint.warning(msg);
      return ResponseModel(status: 0, message: msg);
    }
  }

  Future<ResponseModel<T>> delete<T>({
    required ResponseModel<T> Function(Map<String, dynamic> data) onSuccess,
    required ResponseModel<T> Function(ResponseModel) onError,
    isLogin = false,
    String path = '',
  }) async {
    try {
      if (await checkLogin(isLogin)) {
        if (await connectedToNetwork()) {
          _dio.options.connectTimeout =
              const Duration(milliseconds: 30000); //5s
          _dio.options.receiveTimeout = const Duration(milliseconds: 30000);
          sPrint.info('link ${path.contains('http') ? path : apiUrl() + path}');
          _response =
              await _dio.request(path.contains('http') ? path : apiUrl() + path,
                  onSendProgress: showProgress,
                  options: Options(method: 'DELETE', headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    // "fcm_token": await PushNotificationsManager().getNotificationToken(),
                    "lang": TLang.getCurrentLocale().name,
                    "Accept-Language": TLang.getCurrentLocale().name,
                    if (isLogin)
                      'Authorization': 'Bearer $token'
                  }));
          sPrint.warning(_response.data);
          if (_response.statusCode == 200 && _response.data is! String) {
            sPrint.success("response in dio: ${_response.data}");
            return onSuccess(_response.data);
          } else {
            if (_response.data is String) {
              return onError(ResponseModel(
                  status: 0, message: "backend response error in Api $path"));
            }
            return onError(ResponseModel.fromJson(_response.data));
          }
        } else {
          throw ('internet connection error');
        }
      } else {
        return ResponseModel(status: 2, message: 'need to authenticate');
      }
    } catch (error, s) {
      String msg = '';
      if (error is DioException) {
        DioExceptions dioExceptions = DioExceptions.fromDioError(error);
        msg = dioExceptions.message.message.toString();
        return onError(dioExceptions.message);
      } else {
        sPrint.error(error.toString(), s);
        msg = error.toString();
      }
      sPrint.warning(msg);
      return ResponseModel(status: 0, message: msg);
    }
  }
}

void showProgress(received, total) {
  final loadController = Get.find<LoadingGetxController>();
  if (total != -1) {
    String progress = (received / total * 100).toStringAsFixed(0) + "%";
    sPrint.info(progress);
    loadController.setProgress(progress);
  }
}

Future<bool> connectedToNetwork() async {
  bool isInternet = await InternetConnectionChecker.instance.hasConnection;
  if (isInternet) {
    return true;
  } else {
    return false;
  }
}



// Future<bool> connectedToNetwork() async {
//   try {
//     final result = await InternetAddress.lookup('google.com')
//         .timeout(const Duration(seconds: 5));
//     return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//   } on TimeoutException catch (_) {
//     return false;
//   } on SocketException catch (_) {
//     return false;
//   } catch (_) {
//     return false;
//   }
// }

final dioLoggerInterceptor =
    InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
  String headers = "";
  options.headers.forEach((key, value) {
    headers += "| $key: $value";
  });

  log("┌------------------------------------------------------------------------------");
  log('''| [DIO] Request: ${options.method} ${options.uri}
| ${options.data.toString()}
| Headers:\n$headers''');
  log("├------------------------------------------------------------------------------");
  handler.next(options); //continue
}, onResponse: (Response response, handler) async {
  log("| [DIO] Response [code ${response.statusCode}]: ${response.data.toString()}");
  log("└------------------------------------------------------------------------------");
  handler.next(response);
  // return response; // continue
}, onError: (DioException error, handler) async {
  log("| [DIO] Error: ${error.error}: ${error.response.toString()}");
  log("└------------------------------------------------------------------------------");
  handler.next(error); //continue
});

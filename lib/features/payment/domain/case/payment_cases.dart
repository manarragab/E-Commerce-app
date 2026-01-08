import 'package:ecommerce_app/data/models/payment/kiosk_payment_response.dart';
import 'package:ecommerce_app/data/models/payment/payment_token/auth_token/auth_token_response.dart';
import 'package:ecommerce_app/data/models/payment/payment_token/auth_token/post_api_key.dart';
import 'package:ecommerce_app/data/models/payment/payment_token/final_token/final_token_response.dart';
import 'package:ecommerce_app/data/models/payment/payment_token/final_token/post_final_token.dart';
import 'package:ecommerce_app/data/models/payment/payment_token/order_id/order_id_response.dart';
import 'package:ecommerce_app/data/models/payment/payment_token/order_id/post_order_id.dart';
import 'package:ecommerce_app/data/models/payment/post_kiosk_payment.dart';
import 'package:ecommerce_app/data/remote_data/response_model.dart';
import 'package:ecommerce_app/domain_data/repositories/domain_repositry.dart';

class PaymentCases {
  final DomainData _data;

  PaymentCases(this._data);

  Future<ResponseModel<ResponseApiKey?>> authToken(PostApiKey authToken) {
    return _data.authToken(authToken);
  }

  Future<ResponseModel<ResponseOrderId?>> orderId(PostOrderId postOrderId) {
    return _data.orderId(postOrderId);
  }

  Future<ResponseModel<ResponseFinalToken?>> paymentToken(PostFinalToken postFinalToken) {
    return _data.paymentToken(postFinalToken);
  }
  
  
Future<void> setPaymentToken( String? token) {
    return _data.setPaymentToken(token);
  
}
  String? getPaymentToken() {
    return _data.getPaymentToken();
  }

  Future<ResponseModel<KioskPaymentResponse?>> kioskPayment(PostPaymentKiosk postPaymentKiosk) {
    return _data.kioskPayment(postPaymentKiosk);
  }



}


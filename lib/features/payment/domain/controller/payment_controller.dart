import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/data/const/keys.dart';
import 'package:ecommerce_app/data/data_sources/get_storage.dart';
import 'package:ecommerce_app/data/models/payment/kiosk_payment_response.dart' hide BillingData;
import 'package:ecommerce_app/data/models/payment/payment_token/auth_token/auth_token_response.dart';
import 'package:ecommerce_app/data/models/payment/payment_token/auth_token/post_api_key.dart';
import 'package:ecommerce_app/data/models/payment/payment_token/final_token/final_token_response.dart';
import 'package:ecommerce_app/data/models/payment/payment_token/final_token/post_final_token.dart';
import 'package:ecommerce_app/data/models/payment/payment_token/order_id/order_id_response.dart';
import 'package:ecommerce_app/data/models/payment/payment_token/order_id/post_order_id.dart';
import 'package:ecommerce_app/data/models/payment/post_kiosk_payment.dart';
import 'package:ecommerce_app/features/auth/domain/controller/auth_controller.dart';
import 'package:ecommerce_app/features/payment/domain/case/payment_cases.dart';

class PaymentController extends MainGetxController {
  
  final paymentFormKey = GlobalKey<FormState>();

  final fNameTextField= TextEditingController();
  final lNameTextField= TextEditingController();
  final emailTextField= TextEditingController();
  final phoneTextField= TextEditingController();
  final amountTextField= TextEditingController();

var price;
txtFields(){
    final auth = Get.find<AuthController>();
    final parts = auth.name?.trim().split(RegExp(r'\s+')) ?? [];
    fNameTextField.text = parts.isNotEmpty ? parts.first : '';
    lNameTextField.text = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    emailTextField.text = auth.email ?? '';
    postFinalToken.billingData = BillingData(
      firstName: fNameTextField.text,
      lastName: lNameTextField.text,
      email: emailTextField.text,
      phoneNumber: phoneTextField.text,
    );
postFinalToken.amountCents = int.tryParse(price.toString()) ?? 0;
}

@override
  void onInit() {
    super.onInit();
    txtFields();
}

  PostApiKey postApiKey = PostApiKey();
  ResponseApiKey responseApiKey= ResponseApiKey();

  String? authToken;

Future<void> getAuthToken(String idd) async {
  loadingGetxController.showCustomLoading(idd);
  
  postApiKey.apiKey=CustomKeys.apiKey;
  
  var response = await sl<PaymentCases>().authToken(postApiKey);
  loadingGetxController.hideCustomLoading(idd);
  statusError.checkStatus(
    response,
    () async {
      if(response.data != null){
       responseApiKey = response.data!;
      sPrint.info('response data:: ${response.data!.token}');
      authToken = responseApiKey.token!;
      }
        else{
            loadingGetxController.hideCustomLoading(idd);

           sPrint.error('No data received from authToken' , StackTrace.current);
        Get.snackbar("خطأ", "فشل في استلام بيانات المصادقة");
        return; 
        }
    },
    onError: (msg) {
      Get.snackbar("خطأ", msg ?? "فشل تسجيل الدخول");
  loadingGetxController.hideCustomLoading(idd);

    },
  );
}



PostOrderId postOrderId = PostOrderId();
ResponseOrderId responseOrderId= ResponseOrderId();
  int? id;

Future<void> getOrderId(String idd) async {
  loadingGetxController.showCustomLoading(idd);
  postOrderId.authToken= authToken;
  postOrderId.currency= "EGP";
  postOrderId.apiSource= "INVOICE";
  
  var response = await sl<PaymentCases>().orderId(postOrderId);
  
  print("amounttttt ${postOrderId.amountCents}");
  loadingGetxController.hideCustomLoading(idd);
  statusError.checkStatus(
    response,
    () async {
      if(response.data != null){
       responseOrderId = response.data!;
      sPrint.info('responseOrderId :: ${responseOrderId.id }');
      id = response.data!.id!;
      print("jjjjjjjjjjjjjjjjjjjjjjj ${postOrderId.amountCents}");

      }
        else{
            loadingGetxController.hideCustomLoading(idd);

           sPrint.error('No data received from authToken' , StackTrace.current);
        Get.snackbar("خطأ", "فشل في استلام بيانات المصادقة");
        return; 
        }
    },
    onError: (msg) {
      Get.snackbar("خطأ", msg ?? "فشل");
     loadingGetxController.hideCustomLoading(idd);


    },
  );
}

clearTextFields(){
  fNameTextField.clear();
  lNameTextField.clear();
  emailTextField.clear();
  phoneTextField.clear();
  amountTextField.clear();
  //postFinalToken.billingData = null;
  postFinalToken =PostFinalToken();
  postApiKey = PostApiKey();
  postOrderId = PostOrderId();
  postPaymentKiosk = PostPaymentKiosk();
  serviceCodeKiosk = null;
}


billingData(){
  postFinalToken.billingData.firstName= fNameTextField.text;
  postFinalToken.billingData.lastName= lNameTextField.text;
  postFinalToken.billingData.email= emailTextField.text;
  postFinalToken.billingData.phoneNumber= phoneTextField.text;
  postFinalToken.lockOrderWhenPaid= "false";
  postFinalToken.billingData.street = "NA";
  postFinalToken.billingData.building = "NA";
  postFinalToken.billingData.floor = "NA";
  postFinalToken.billingData.apartment = "NA";
  postFinalToken.billingData.city = "NA";
  postFinalToken.billingData.country = "Egypt";
  postFinalToken.billingData.postalCode = "NA";

}

PostFinalToken postFinalToken = PostFinalToken();
ResponseFinalToken responseFinalToken= ResponseFinalToken();
 String? paymentToken;
 String? paymentTokenKioskk;
 String? paymentTokenWallet;

Future<void> finalPaymentToken(String idd ,int integration_id ) async {
  loadingGetxController.showCustomLoading(idd);
  postFinalToken.authToken= authToken;
  postFinalToken.orderId= id.toString();
 //online card payment id
  //postFinalToken.integrationId= 5268837;
  postFinalToken.integrationId=integration_id;
  postFinalToken.currency= "EGP";
billingData();

  var response = await sl<PaymentCases>().paymentToken(postFinalToken);
  loadingGetxController.hideCustomLoading(idd);
  statusError.checkStatus(
    response,
    () async {
      if(response.data != null){
       responseFinalToken = response.data!;
      sPrint.info('responseOrderId :: ${responseOrderId.id }');
      if(integration_id == 5268837){
        paymentToken = response.data!.token!;
     // await sl<GetStorageData>().setPaymentToken(paymentToken ??'');
      } else if(integration_id == 5448944){
        paymentTokenKioskk = response.data!.token!;
      }else if(integration_id == 5456542){
        paymentTokenWallet = response.data!.token!;
      }

      }
        else{
            loadingGetxController.hideCustomLoading(idd);

           sPrint.error('No data received from paymentVisa' , StackTrace.current);
        Get.snackbar("خطأ", "فشل في استلام بيانات المصادقة");
        return; 
        }
    },
    onError: (msg) {
      Get.snackbar("خطأ", msg ?? "فشل");
      loadingGetxController.hideCustomLoading(idd);


    },
  );
}


Future<void> visaToken({String idd=''}) async{
await getAuthToken( idd);
print('authToken :::::::::::::::::;; $authToken ');
await getOrderId(idd);
print('orderId :::::::::::::::::;; $id ');
await finalPaymentToken(idd ,5268837 );
print('paymentToken :::::::::::::::::;; $paymentToken ');
loadingGetxController.hideCustomLoading(idd);

}

void resetPaymentToken(){
  paymentToken = '';
}
 


PostPaymentKiosk postPaymentKiosk = PostPaymentKiosk();
KioskPaymentResponse responsePaymentKiosk= KioskPaymentResponse();
 int? serviceCodeKiosk;
 int? serviceCodeWallet;

Future<void> kioskPayment({String idd=''}) async {
  loadingGetxController.showCustomLoading(idd);
  postPaymentKiosk.paymentToken= paymentTokenKioskk;
  // postPaymentKiosk.source?.identifier="AGGREGATOR";
  //   postPaymentKiosk.source?.subtype="AGGREGATOR";

  postPaymentKiosk.source = Source(
  identifier: "AGGREGATOR",
  subtype: "AGGREGATOR",
);

  var response = await sl<PaymentCases>().kioskPayment(postPaymentKiosk);
  loadingGetxController.hideCustomLoading(idd);
  statusError.checkStatus(
    response,
    () async {
      if(response.data != null){
       responsePaymentKiosk = response.data!;
      sPrint.info('responsedKiosk :: ${response.data!.id }');
      if(idd== 'kiosk'){
serviceCodeKiosk = response.data!.id!;
      }else{
serviceCodeWallet = response.data!.id!;
      }
      
  loadingGetxController.hideCustomLoading(idd);

      }
      else{
  loadingGetxController.hideCustomLoading(idd);

        sPrint.error('No data received from paymentToken' , StackTrace.current);
        Get.snackbar("خطأ", "فشل في استلام بيانات المصادقة");
        return; 
      }
    },
    onError: (msg) {
      Get.snackbar("خطأ", msg ?? "فشل");
    },
  );
}



Future<void> kioskToken({String idd=''}) async{
await getAuthToken( idd);
print('authToken :::::::::::::::::;; $authToken ');
await getOrderId( idd);
print('orderId :::::::::::::::::;; $id ');
await finalPaymentToken(idd , 5448944);
print('paymentToken :::::::::::::::::;; $paymentTokenKioskk ');
            loadingGetxController.hideCustomLoading(idd);

}



Future<void> walletToken({String idd=''}) async{
await getAuthToken( idd);
print('authToken :::::::::::::::::;; $authToken ');
await getOrderId( idd);
print('orderId :::::::::::::::::;; $id ');
await finalPaymentToken(idd , 5456542);
print('paymentToken :::::::::::::::::;; $paymentTokenWallet ');
  loadingGetxController.hideCustomLoading(idd);

}


}
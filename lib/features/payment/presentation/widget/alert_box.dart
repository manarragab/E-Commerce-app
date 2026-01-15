import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/features/payment/domain/controller/payment_controller.dart';

class AlertBox extends StatelessWidget{
final  String? txt;
  const AlertBox({Key? key , this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentController>();
    return AlertDialog(
      scrollable: true,
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(40),
     ),
    title:
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
      CustomImage.asset('assets/images/correct.png', height: 50, width: 50,),
     Text('Reference Number:'),
     const SizedBox(height: 10),
     Center(
       child: Text(
         '${txt}' ,
         style: TFonts.montFont(fontSize: 30, fontWeight: FontWeight.bold),
       ),
     ),
    ],),
    content: Column(
      children: [
        Text('To pay, please go to the cashier of the supermarket and tell him the reference number.'),
           Text('Also the number is sent to your mail :  ', style: TFonts.montFont(fontSize: 14,),), 
Center(child: Text(' ${controller.postFinalToken.billingData.email} ', style: TFonts.montFont(fontSize: 15,color: Colors.lightBlue ,fontWeight: FontWeight.w500),)),
      ],
    ),
    actions: [
      TextButton(
       
        child: Text('OK'),
        onPressed: () {
        Get.back();
        controller.serviceCodeKiosk = null;
        },
      ), ], 
  );
}}
import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/features/payment/domain/controller/payment_controller.dart';
import 'package:ecommerce_app/features/payment/presentation/widget/alert_box.dart';
import 'package:ecommerce_app/res/configuration/open_url/launch_url.dart';
import 'package:ecommerce_app/res/loading/loading_overlay_widget.dart';
import 'package:ecommerce_app/res/router/pages.dart';
import 'package:flutter/material.dart';

class ChoosePayScreen extends StatelessWidget{
  const ChoosePayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentController>();
  return Scaffold(
    appBar: CustomAppBar.appBar("Payment Ways"),
    body:  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(child: 
      Column(children: [
       SizedBox(height: 50,),
      
      LoadingOverLay(
        showLoadingOnly: true,
            id: "visa",
      
        child: MainButton(
            onPressed: () async{
                 
              await controller.visaToken(idd: "visa");
              final paymentToken = controller.paymentToken;    
            
            if(paymentToken != null){
  CustomLauncher.launchInBrowser(Uri.parse("https://accept.paymob.com/api/acceptance/iframes/957399?payment_token=$paymentToken"));
            }
            },
            title: "Visa",
            width: 150,
            radius: 15,
            backgroundColor: CustomColors.darkBlue,
        
          ),
      ),
      
       SizedBox(height: 50,),
      
      
        LoadingOverLay(
          showLoadingOnly: true,
          id: "kiosk",
          child: MainButton(
            onPressed: () async{
               await controller.kioskToken(idd: "kiosk");
               if(controller.paymentTokenKioskk != null){
              await controller.kioskPayment(idd: "kiosk");
      print("${controller.serviceCodeKiosk} kiosk");
      if(controller.serviceCodeKiosk != null){
        Get.dialog(
        AlertBox(txt: controller.serviceCodeKiosk.toString(),),

        );
      }
               }
               
            },
            title: "Cash",
            width: 150,
             radius: 15,
            backgroundColor: CustomColors.primary,
          
          ),
        ),
    
     SizedBox(height: 50,),


 LoadingOverLay(
          showLoadingOnly: true,
          id: "wallet",
          child: MainButton(
            onPressed: () async{
               await controller.walletToken(idd: "wallet");
               if(controller.paymentTokenWallet != null){
              await controller.kioskPayment(idd: "wallet");
                 
                 print(controller.serviceCodeWallet);
                 if(controller.serviceCodeWallet != null){
                   

                   Get.dialog(
                   AlertBox(txt: controller.serviceCodeWallet.toString(),),

                   );
                 }

               }
               
            },
            title: "mobile wallet",
            width: 150,
            radius: 15,
            backgroundColor: CustomColors.green,
          
          ),
        ),
Spacer(),
MainButton(onPressed: (){
  Get.toNamed(CustomPage.homePage);
},
title: "Go to home",
),
SizedBox(height: 30,),
      ],)
      ),
    ),
  );
  }

}
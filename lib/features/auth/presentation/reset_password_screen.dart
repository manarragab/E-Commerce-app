import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/features/auth/domain/controller/auth_controller.dart';
import 'package:ecommerce_app/res/configuration/text_field/text_field.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget{


  String otp = '';

  @override
  Widget build(BuildContext context) {
    final authcontroller = Get.find<AuthController>();
    return Scaffold(
      appBar:CustomAppBar.appBar(""),
      body: Form(
        key: authcontroller.resetPasswordFormKey,
        child: ListView(
          children: [
            Text("Reset\npassword", style: TFonts.montFont(fontSize: 30, fontWeight: FontWeight.bold),),
          
            SizedBox(height: 16,),
            Text("Please enter new password.", style: TFonts.montFont(fontSize: 16, fontWeight: TFontWights.regular),),
            SizedBox(height: 30,),
        
            CustomTextField.emailTextField(
              controller: authcontroller.emailController4,
              (val){
                authcontroller.emailController4.text=authcontroller.loginModel.email.toString();
              },
             
            ),
            SizedBox(height: 20,),
        
          CustomTextField.passwordTextField(
          controller: authcontroller.passwordController4,
          hint: "new password",
            (val){},
             isVisible: authcontroller.hidePassword4.value,
              changeVisible: (){
                authcontroller.hidePassword4.value = !authcontroller.hidePassword4.value;
              },  
              eyeIcon: false
            ),
            
            SizedBox(height: 20,),


         CustomTextField.otpTextField(
         // controller: authcontroller.otpController,
          (val){}, hint: "OTP",
           prefixIcon: const Icon(Icons.code)),

            SizedBox(height: 30,),
        
            MainButton(onPressed: (){
            
            if(authcontroller.resetPasswordFormKey.currentState!.validate()){
  
           
  
    }

            }, title: "Done", backgroundColor: CustomColors.lightRED, radius: 8, withShadow: false,),
        
          ],
        ),
      )
    );
  }

}
import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/features/auth/domain/controller/auth_controller.dart';
import 'package:ecommerce_app/res/configuration/fonts.dart';
import 'package:ecommerce_app/res/configuration/text_field/text_field.dart';
import 'package:ecommerce_app/res/loading/loading_overlay_widget.dart';
import 'package:ecommerce_app/res/router/pages.dart';

class ForgetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    return Scaffold(
        appBar: CustomAppBar.appBar(""),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child:
            
             Form(
              key: authController.forgetPasswordFormKey,
               child: LoadingOverLay(
                showLoadingOnly: true,
                 child: ListView(children: [
                  Text(
                    "Forget\npassword",
                    style:
                        TFonts.montFont(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField.emailTextField(
                    controller: authController.emailController3,
                    hint: "Enter your email address",
                    (val) {
                      authController.emailController3.text = authController.postRegister.email.toString();

                    },
                  ),
                  SizedBox(height: 25),
                  Text(
                      "* We will send you an OTP to set or reset your new password",
                      style: TFonts.montFont(
                          fontSize: 12, color: CustomColors.grey11)),
                  SizedBox(height: 40),
                  
                  MainButton(
                    onPressed: () {
                 
                 if(authController.forgetPasswordFormKey.currentState!.validate()){
                        authController.postRegister.email =
                            authController.emailController3.text;
                        authController.forgetPassword(authController.postRegister.email!);
                      }
                 
                    },
                    title: "Submit",
                    backgroundColor: CustomColors.lightRED,
                    radius: 8,
                    withShadow: false,
                  ),
                             ]),
               ),
             )));
  }
}

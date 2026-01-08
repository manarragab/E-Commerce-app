import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/features/auth/domain/controller/auth_controller.dart';
import 'package:ecommerce_app/res/configuration/text_field/text_field.dart';
import 'package:ecommerce_app/res/loading/loading_overlay_widget.dart';
import 'package:ecommerce_app/res/router/pages.dart';

class RegisterScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
     AuthController authController = Get.find<AuthController>();
    return Scaffold(
      appBar: CustomAppBar.appBar(""),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: LoadingOverLay(
          showLoadingOnly: true,
          child: Form(
            key: authController.registerFormKey,
            child: ListView(
              
              children: [
                Text("Create an\naccount", style: TFonts.montFont(fontSize: 30, fontWeight: FontWeight.bold),),
                SizedBox(height: 30,),
                  
                  CustomTextField.nameTextField(
                  controller: authController.firstNameController,
                  hint: "first Name",
                  (val){
                    authController.postRegister.firstName = val;
                  },
                ),
            
                SizedBox(height: 25,),
                 CustomTextField.nameTextField(
                  controller: authController.lastNameController,
                  hint: "last Name",
                  (val){
                    authController.postRegister.lastName = val;
                  },
                ),
            
                SizedBox(height: 25,),
            
                CustomTextField.emailTextField(
                  controller: authController.emailController2,
                  hint: "email",
                  (val){
                    authController.postRegister.email = val;
                  },
                  prefixIcon: Icon(Icons.email)
                ),
            
                SizedBox(height: 25,),
                  Obx(()=>   CustomTextField.passwordTextField(
                  controller: authController.passwordController2,
                  // validator: (val){
                  //   if(val == null || val.isEmpty){
                  //     return "Password is required";
                  //   }else if(val.length < 6){
                  //     return "Password must be at least 6 characters";
                  //   }
                  //   return null;
                  // },
                  
                  (val){
                    authController.postRegister.password = val;
                  },
                   isVisible: authController.hidePassword1.value,
                  changeVisible: (){
                  authController.hidePassword1.value = !authController.hidePassword1.value;
                  },
              
                ),),
                SizedBox(height: 20,),
            
            //         Obx(()=>
            //         CustomTextField.passwordTextField(
            //           controller: authController.confirmPasswordController,
            //               hint: "Confirm Password",
            //               (val){},
            //               isVisible: authController.hidePassword2.value,
            //               changeVisible: (){
            // authController.hidePassword2.value = !authController.hidePassword2.value;
            //               },
            //             ),
            //         )    ,
              
            
                Text("By clicking the Register button, you agree to the public offer",
                 style: TFonts.montFont(fontSize: 12,color: CustomColors.grey2),),
            
                SizedBox(height: 20,),        
            
                MainButton(onPressed: (){

                   if (authController.registerFormKey.currentState!.validate()) {
                  
                      authController.register();
                    }
                },
                title: "Create Account",
                backgroundColor: CustomColors.lightRED,
                radius: 8,
                 withShadow: false,
                ),
            
                SizedBox(height: 30,),
                Center(child: Text("-OR continue with-", style: TFonts.montFont(fontSize: 12,color: CustomColors.textDark),)),
                SizedBox(height: 15,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 75),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    
                  containerLogin("assets/images/google.png"),
                  containerLogin("assets/svg/apple.svg"),
                  containerLogin("assets/svg/facebook.svg"),
                  ],),
                ),
            
                SizedBox(height: 25,),
            
                Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                 Text("I Already Have an Account", style: TFonts.montFont(fontSize: 14,color: CustomColors.grey11),),
                
                GestureDetector(
                  onTap: (){
                    Get.toNamed(CustomPage.loginPage);
                  },
                  child: Text("Login", style: TFonts.montFont(fontSize: 14,color: CustomColors.lightRED ,
                  textDecoration: TextDecoration.underline
                  ),),
                ),
                ]),
               ],
            ),
          ),
        ),
      )
    );
  }


  Widget containerLogin(String imagePath){
    return Container(
      height: 53,
      width: 53,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CustomColors.lightPink,
        border: Border.all(color: CustomColors.lightRED , width: 1.5)
      ),
      child: Center(
        child: CustomImage.asset(imagePath, height: 24, width: 24,),
      ),
    );
  }
}
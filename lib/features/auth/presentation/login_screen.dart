import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/features/auth/domain/controller/auth_controller.dart';
import 'package:ecommerce_app/res/configuration/text_field/text_field.dart';
import 'package:ecommerce_app/res/loading/loading_overlay_widget.dart';
import 'package:ecommerce_app/res/router/pages.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
      child: Form(
        
        key: authController.registerFormKey2,
        child: LoadingOverLay(
          showLoadingOnly: true,
          child: ListView(
            children: [
              MainButton(onPressed: () {
                Get.toNamed(CustomPage.homePage);
              }),
              Text(
                "Welcome\nBack",
                style:
                    TFonts.montFont(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextField.emailTextField(
                controller: authController.emailController1,
                autoFillHints: ["username or email"],
                (val) {
                  //authController.emailController1.text="m22090121@gmail.com";
                  authController.postLogin.email = val;
                  print("email: ${authController.postLogin.email}");
                },
              ),
              SizedBox(
                height: 25,
              ),
              Obx(
                () => CustomTextField.passwordTextField(
                  controller: authController.passwordController1,
                  (val) {
                    // authController.passwordController1.text="Man0.0ham";
                    authController.postLogin.password =
                        authController.passwordController1.text;
                  },
                  isVisible: authController.hidePassword3.value,
                  changeVisible: () {
                    authController.hidePassword3.value =
                        !authController.hidePassword3.value;
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {
                        Get.toNamed(CustomPage.forgetPasswordPage);
                        print("vvvvv${authController.loginModel.email}");
                        print("vvnnv${authController.postRegister.email}");
                      },
                      child: Text(
                        "Forgot password",
                        style: TFonts.montFont(
                            fontSize: 12, color: CustomColors.lightRED),
                      ))),
              SizedBox(
                height: 40,
              ),
              MainButton(
                onPressed: () {
                  if (authController.registerFormKey2.currentState!
                      .validate()) {
                    authController.postLogin.email =
                        authController.emailController1.text;
                    authController.postLogin.password =
                        authController.passwordController1.text;
                    authController.login();
                    }
                },
                title: "Login",
                backgroundColor: CustomColors.lightRED,
                radius: 8,
                withShadow: false,
              ),
              SizedBox(
                height: 60,
              ),
              Center(
                  child: Text(
                "-OR continue with-",
                style:
                    TFonts.montFont(fontSize: 12, color: CustomColors.textDark),
              )),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 75),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    containerLogin("assets/images/google.png"),
                    containerLogin("assets/svg/apple.svg"),
                    containerLogin("assets/svg/facebook.svg"),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Create An Account-",
                  style:
                      TFonts.montFont(fontSize: 14, color: CustomColors.grey11),
                ),
                GestureDetector(
                    onTap: () {
                      Get.toNamed(CustomPage.registerPage);
                    },
                    child: Text(
                      "Sign Up",
                      style: TFonts.montFont(
                          fontSize: 14,
                          color: CustomColors.lightRED,
                          textDecoration: TextDecoration.underline),
                    )),
              ]),
              InkWell(
                  onTap: () {
                    Get.toNamed(CustomPage.forgetPasswordPage);
                  },
                  child: Text("forget,")),
              InkWell(
                  onTap: () {
                    Get.toNamed(CustomPage.otpPage);
                  },
                  child: Text("otp,")),
              GetBuilder<AuthController>(
                builder: (controller) {
                  return Text(controller.loginModel.email.toString());
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget containerLogin(String imagePath) {
    return Container(
      height: 53,
      width: 53,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.lightPink,
          border: Border.all(color: CustomColors.lightRED, width: 1.5)),
      child: Center(
        child: CustomImage.asset(
          imagePath,
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}

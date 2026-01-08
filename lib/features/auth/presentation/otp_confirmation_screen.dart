import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/features/auth/domain/controller/auth_controller.dart';
import 'package:ecommerce_app/res/loading/loading_overlay_widget.dart';
import 'package:pinput/pinput.dart';

class OtpConfirmationScreen extends GetView<AuthController> {
  OtpConfirmationScreen({this.getCode, this.resendCode, Key? key})
      : super(key: key);
  String otp = '';
  Function(String)? getCode;
  Function? resendCode;

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<AuthController>();
    return Scaffold(
      appBar: CustomAppBar.appBar(""),
      body: LoadingOverLay(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  CustomTrans.verificationCode.tr,
                  style: TFonts.textTitleStyle(
                      fontSize: 18, fontWeight: TFontWights.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  CustomTrans
                      .pleaseEnterTheVerificationCodeAndExploreTheWorld.tr,
                  style: TFonts.textTitleStyle(
                      fontSize: 16, fontWeight: TFontWights.regular),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                        length: 6,
                        keyboardType: TextInputType.text,
                        defaultPinTheme: PinTheme(
                          width: 48,
                          height: 48,
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: CustomColors.primary,
                              fontWeight: FontWeight.w600),
                          decoration: BoxDecoration(
                            border: Border.all(color: CustomColors.grey),
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffD9D9D9),
                          ),
                        ),
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        submittedPinTheme: PinTheme(
                          height: 48,
                          width: 48,
                          textStyle: TFonts.textTitleStyle(),
                          decoration: BoxDecoration(
                            color: const Color(0xffD9D9D9),
                            border: Border.all(color: CustomColors.lightRED),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        showCursor: true,
                        onChanged: (value) {
                          otp = value;
                        },
                        onCompleted: (value) {}),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: GetBuilder<AuthController>(builder: (controller) {
                    // Calculate minutes and seconds
                    int minutes = controller.counter ~/ 60;
                    int seconds = controller.counter % 60;

                    // Format as mm:ss
                    String formattedTime =
                        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
                    return SizedBox(
                        //height: 50.h,
                        width: Get.width,
                        child: Column(
                          children: [
                            SizedBox(
                                child: Text(
                              formattedTime,
                              textAlign: TextAlign.center,
                              style: TFonts.textTitleStyle(
                                color: CustomColors.secondary,
                                fontSize: 14,
                              ),
                            )),
                            SizedBox(
                              height: 20.h,
                            ),
                            Obx(() => controller.isZero.value
                                ? Center(
                                    child: InkWell(
                                      onTap: () async {
                                        if (controller.counter == 0 &&
                                            !controller.isResending.value) {
                                          await controller.resendOTP(
                                              controller.postRegister.email!);
                                          controller.startCount();
                                        }
                                      },
                                      child: controller.isResending.value
                                          ? SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: CustomColors.lightRED,
                                              ),
                                            )
                                          : Text(
                                              CustomTrans.resendCode.tr,
                                              style: TFonts.montFont(
                                                color: CustomColors.third,
                                                textDecoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                    ),
                                  )
                                : const SizedBox()),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ));
                  }),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: MainButton(
                      onPressed: () async {
                        // widget.controller.incrementCurrentStep();

                        if (otp.isNotEmpty) {
                          controller.postOtp.otp = otp;
                          controller.postOtp.email = controller.postRegister.email;
                          await controller.verifyOTP(controller.postOtp);
                        } else {
                          showToast(CustomTrans.please_enter_otp.tr,
                              MessageErrorType.error);
                        }
                      },
                      textColor: CustomColors.white,
                      title: CustomTrans.verify.tr),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

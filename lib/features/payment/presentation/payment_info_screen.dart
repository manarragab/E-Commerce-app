import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/features/auth/domain/controller/auth_controller.dart';
import 'package:ecommerce_app/features/payment/domain/controller/payment_controller.dart';
import 'package:ecommerce_app/res/configuration/text_field/text_field.dart';
import 'package:ecommerce_app/res/router/pages.dart';

class PaymentInfoScreen extends StatefulWidget {

  PaymentInfoScreen({Key? key}) : super(key: key);

  @override
  State<PaymentInfoScreen> createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {
GlobalKey formKey = GlobalKey<FormState>();

AuthController authController = Get.find<AuthController>();
final controller = Get.find<PaymentController>();

  @override
  void initState() {
    super.initState();
    controller.txtFields();
    controller.amountTextField.text = Get.arguments.toString();
  }

  @override
  Widget build(BuildContext context) {
// controller.fNameTextField.text =authController.name?.split(' ').first ?? '';
// controller.lNameTextField.text =authController.name?.split(' ').skip(1).join(' ') ?? '';
// controller.emailTextField.text = authController.email ?? '';
  
    final price = Get.arguments;

    return Scaffold(
      appBar: CustomAppBar.appBar(""),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: controller.paymentFormKey,
          child: 
        ListView(
          children: [
            Text("User payment information :", style: TFonts.montFont(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 30,),
        CustomTextField.nameTextField(
          controller: controller.fNameTextField,
          (val){
  controller.postFinalToken.billingData.firstName = val ;
 print("${controller.postFinalToken.billingData.firstName} vvvvv");
print("${val} val");
          },
            hint: "First Name.."
        ),
        
        SizedBox(height: 20,),
        
        CustomTextField.nameTextField(
          controller: controller.lNameTextField,
          (val){
  controller.postFinalToken.billingData.lastName= val;

          },
          hint: "Last Name.."
         
        ),
        SizedBox(height: 20,),
        
        CustomTextField.emailTextField(
          controller: controller.emailTextField,
          (val){
  controller.postFinalToken.billingData.email= val;

          },
            hint: "Email.."
        ),
        SizedBox(height: 20,),
        
        CustomTextField.phoneTextField(
          controller: controller.phoneTextField,
          (val){
  controller.postFinalToken.billingData.phoneNumber= val;

          },
            hint: "phone Number.."
        ),
                SizedBox(height: 20,),

        CustomTextField.numberTextField(
          controller: controller.amountTextField,
       (val) {
        
    controller.amountTextField.text = price.toString();
        val=price;
  final parsed = int.tryParse(val.trim()) ?? 0; 
  final x = parsed * 100;
  controller.postFinalToken.amountCents = x;
  controller.postOrderId.amountCents = x.toString();
  
       },
            hint: "Budget amount.. LE"
        ),
        
        SizedBox(height: 30,),
        MainButton(onPressed: (){

     if(controller.paymentFormKey.currentState!.validate()){
    
      print("valid ${controller.postFinalToken.billingData.lastName} , ${controller.postFinalToken.billingData?.firstName} , ${controller.postFinalToken.billingData?.email} , ${controller.postFinalToken.billingData?.phoneNumber} , ${controller.postFinalToken.amountCents}");
    
    Get.toNamed(CustomPage.choosePayPage);
    controller.clearTextFields();
     }  

        },
        title: "Let's go",
        )
        
        
          ],
        )
        
        ),
      )
    );
  }
}
import 'dart:async';
import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/res/router/pages.dart';

class SplashController extends MainGetxController{

  var activeIndex = 0.obs;
  late Timer timer;

@override
void onInit() {
  super.onInit();
  
  timer = Timer.periodic(const Duration(seconds: 5), (timer) {
  next();
    });
}

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }


List<String> txt1=[
  "Choose Products",
  "Make Payment",
  "Get Your Order"
];

List<String> images=[
  "assets/svg/splash1.svg",
  "assets/svg/splash2.svg",
  "assets/svg/splash3.svg",
];


void next(){
  if (activeIndex.value < 2) {
        activeIndex.value++;
      } else {
        activeIndex.value = 0;
      } 
}

void prev(){
  if (activeIndex.value > 0) {
    activeIndex.value--;
  } else {
    activeIndex.value = 2;
  }
}

}

import 'package:ecommerce_app/data/const/export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/controller/splash_controller.dart';

class SplashDots extends StatelessWidget {
  const SplashDots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          final isActive = index == controller.activeIndex.value;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: isActive ? 30 : 10,
            height: 7,
            decoration: BoxDecoration(
              color: isActive ? CustomColors.lightRED : Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          );
        }),
      );
    });
  }
}

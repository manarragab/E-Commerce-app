import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/res/configuration/fonts.dart';
import 'package:ecommerce_app/res/configuration/image/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


//Expanded / Spacer
//ممنوعين داخل ListView / Scroll

Widget cartWidget({
  required String image,
  required String title,
  required String description,
  required String price,
  double? width,
  double? height,
}) {
  return Container(
     margin: EdgeInsets.symmetric( vertical: 8.0),

    width: width ?? Get.width / 2.3,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 5,
          spreadRadius: 1,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// IMAGE
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: CustomImage.network(
            image,
            height: height ??130, // 👈 بدل Expanded
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        /// TEXT
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
               spacing: 15,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TFonts.montFont(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //const SizedBox(height: 4),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TFonts.montFont(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
              Text(
                "₹$price",
                style: TFonts.montFont(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

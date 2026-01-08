
import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/data/models/products/get/all_products.dart';
import 'package:ecommerce_app/data/remote_data/core.dart';
import 'package:ecommerce_app/features/auth/domain/controller/auth_controller.dart';
import 'package:ecommerce_app/features/home/domain/controller/home_controller.dart';
import 'package:ecommerce_app/features/home/presentation/widget/items/cart_item.dart';
import 'package:ecommerce_app/features/splash/domain/controller/splash_controller.dart';
import 'package:ecommerce_app/features/splash/presentation/widget/splash_dots.dart';
import 'package:ecommerce_app/res/configuration/text_field/text_field.dart';
import 'package:ecommerce_app/res/router/pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final SplashController splashController = Get.find<SplashController>();
    final authController= Get.find<AuthController>();
    return SmartRefresher(
      enablePullDown: true,
      onLoading: () async{
        controller.loadingGetxController.showLoading();
       await controller.getAllProducts();
       await controller.getAllCategories();
       controller.refreshController.loadComplete();
       controller.loadingGetxController.hideLoading();

      },
       controller:  controller.refreshController ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: 
        
          // if (homeController.allProducts == null ||
          //     homeController.allProducts!.isEmpty) {
          //   return const Center(child: CircularProgressIndicator());
          // }
       ListView(
            children: [
              
            const SizedBox(height: 10),
            CustomTextField.searchField(
              hint: "Search any Products",
              (val) {},
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "All Features",
                  style:
                      TFonts.montFont(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                containerWidget("sort", () {}),
                const SizedBox(width: 10),
                containerWidget("filter", () {}),
              ],
            ),
            const SizedBox(height: 10),
            
              MainButton(
                onPressed: () async {
              print("📙 ResponseModel data: ${authController.email}");
                
                },
                title: "Home Body",
              ),
      
              const SizedBox(height: 20),
      
      SizedBox(
        height: 130,
        child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.allCategories?.length ??0,
                  itemBuilder: (context, index) {
                  return  categories(
                    controller.allCategories?[index].image?? "",
                    controller.allCategories?[index].name?? "",
                  );
                  },
                ),
      ),
            const SizedBox(height: 10),
      
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:
               Obx((){
                final _=splashController.activeIndex.value;
           final index = splashController.activeIndex.value % controller.allProducts!.length;
        if(controller.allProducts!.length==0){
          return Text("Loading...");
        }
                return CustomImage.network(              
                   controller.allProducts?[index].images?[0]?? demoImage,
                      width: double.infinity,
                      height: 170,
                      fit: BoxFit.fill);
           }),
                ),
               
                 
      
            const SizedBox(height: 15),
        
            SplashDots(),
      
            const SizedBox(height: 20),
      
            Container(
              height: 70,
              width: Get.width,
              decoration: BoxDecoration(
                color: CustomColors.babyblue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    spacing: 7,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        "Deal of the Day",
                        style: TFonts.montFont(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.white),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            color: CustomColors.white,
                          ),
                          Text(
                            " 22h 55m 20s remaining ",
                            style: TFonts.montFont(
                                fontSize: 16, color: CustomColors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                  MainButton(
                    onPressed: () {},
                    title: "View All =>",
                    width: 120,
                    height: 30,
                    withShadow: false,
                    radius: 4,
                    borderColor: CustomColors.white,
                    backgroundColor: CustomColors.babyblue,
                  ),
                ],
              ),
            ),
         
      
              const SizedBox(height: 20),
      
              SizedBox(
                height: Get.height / 3.2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.allProducts?.length ??0,
                  itemBuilder: (context, index) {
                    final product = controller.allProducts?[index] ?? AllProducts();
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: cartWidget(
                        image: product.images?.first ?? "",
                        title: product.title ?? "",
                        description: product.description ?? "",
                        price: product.price?.toString() ?? "",
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: 20),
      
       Container(
        width: Get.width,
        height: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
      color: CustomColors.grey10,
      borderRadius: BorderRadius.circular(10),
        ),
         child: Row(
                children: [
                  CustomImage.asset(
                    "assets/images/offer.png",
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Special Offer",
                            style: TFonts.montFont(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Text(
                            "We make sure you get the offer you need at best prices",
                            softWrap: true,
                            style: TFonts.montFont(
                              fontSize: 14,
                              color: CustomColors.grey11,
                        ))
                      ],
                    ),
                  )
                ],
              ),
       ),
        
            SizedBox(height: 5),
              
            Container(
                height: 150,
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: CustomColors.grey10,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 150,
                          width: 10,
                          decoration: BoxDecoration(
                            color: CustomColors.yellow,
                          ),
                        ),
                        CustomImage.asset(
                          "assets/images/dots.png",
                          height: 150,
                        ),
                        CustomImage.asset(
                          "assets/images/dots.png",
                          height: 150,
                          width: 150,
                        ),
                        Positioned(
                          top: 5,
                          left: 20,
                          child: CustomImage.asset("assets/images/shose.png",
                              width: 150, height: 150),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Flat and Heels",
                              style: TFonts.montFont(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("Stand a chance to get rewarded",
                              style: TFonts.montFont(
                                  fontSize: 12, color: CustomColors.grey11)),
                          Padding(
                            padding: const EdgeInsets.only(left: 70),
                            child: MainButton(
                              onPressed: () {},
                              title: "Visit Now =>",
                              width: 130,
                              height: 30,
                              withShadow: false,
                              radius: 4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
        
            SizedBox(height: 20),
            ],
          )
      ),
    );
      
  
  }

  
  Widget containerWidget(String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        height: 25,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CustomColors.grey7,
        ),
        child: Center(child: Text(title)),
      ),
    );
  }

  Widget categories(String image,  String name) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
    margin: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              final controller = Get.find<HomeController>();
            controller .resetProducts();
controller.selectedSort = "Default";
   // Get.find<HomeController>().onItemTapped(1 , name );

    Get.toNamed(CustomPage.productPage , arguments:   [ValueKey(controller.title) , name ],  
            );
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              height: 70,
              width: 70,
              
              child: ClipOval(
                 
                child: CustomImage.network(image, height: 30, width: 30)),
            ),
          ),
          const SizedBox(height: 5),
          Text(name, style: TFonts.montFont(fontSize: 12)),
        ],
      ),
    );
  }
}


// import 'package:ecommerce_app/data/const/export.dart';
// import 'package:ecommerce_app/data/data_sources/get_storage.dart';
// import 'package:ecommerce_app/data/remote_data/core.dart';
// import 'package:ecommerce_app/features/auth/domain/controller/auth_controller.dart';
// import 'package:ecommerce_app/features/home/domain/controller/home_controller.dart';
// import 'package:ecommerce_app/features/home/presentation/widget/items/cart_item.dart';
// import 'package:ecommerce_app/features/home/presentation/widget/wishlist_body.dart';
// import 'package:ecommerce_app/features/splash/domain/controller/splash_controller.dart';
// import 'package:ecommerce_app/features/splash/presentation/widget/splash_dots.dart';
// import 'package:ecommerce_app/res/configuration/text_field/text_field.dart';
// import 'package:ecommerce_app/res/router/pages.dart';

// class HomeBody extends StatefulWidget {
//   const HomeBody({super.key});

//   @override
//   State<HomeBody> createState() => _HomeBodyState();
// }

// class _HomeBodyState extends State<HomeBody> {
//   @override
//   Widget build(BuildContext context) {
    
//     final HomeController homeController = Get.find<HomeController>();
//     final SplashController splashController = Get.find<SplashController>();
//     final AuthController authController = Get.find<AuthController>();
//     final products = homeController.allProducts;

//     return  Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
//       child: ListView(
//         children: [
          
//           // ...List.generate(homeController.allCategories.data?.categories?.length ??1, (index) {
//           //   return Text("Category Count: ${homeController.allCategories.data?.categories?[index].name ?? 0}");
//           // }
//           // ),
      
//          // Text("${homeController.allCategories[0].name}"),
//       Text(
//             "Hello, ${authController.name ?? ''}",
//             style: TFonts.montFont(fontSize: 20, ),
//           ),
//          
//           const SizedBox(height: 10),
//           ElevatedButton(
//         onPressed: () async {
//           await sl<GetStorageData>().removeUser();
//           Get.offAllNamed('/login');
//         },
//         child: Text("تسجيل خروج"),
//       ),
      
//           const SizedBox(height: 10),
//           CustomTextField.searchField(
//             hint: "Search any Products",
//             (val) {},
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Text(
//                 "All Features",
//                 style:
//                     TFonts.montFont(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const Spacer(),
//               containerWidget("sort", () {}),
//               const SizedBox(width: 10),
//               containerWidget("filter", () {}),
//             ],
//           ),


//           const SizedBox(height: 10),
//           Container(
//             height: 140,
//             decoration: BoxDecoration(
//               color: CustomColors.grey10,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             padding: const EdgeInsets.all(10),
//             child: ListView(
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               children:
//                   List.generate(homeController.allCategories?.length ??0, (index) {
//                 return categories(
//                   homeController.allCategories?[index].image ?? "",
//                   homeController.allCategories?[index].name?? "",
//                 );
//               }),
//             ),
//           ),
//           const SizedBox(height: 20),
      
//       // AnimatedContainer(
      
//       //   duration: const Duration(milliseconds: 300),
//       //   curve: Curves.easeIn,
//       //   child: Row(
//       //     children: List.generate(3, (index) {
//       //       return Padding(
//       //         padding: const EdgeInsets.all(5),
//       //         child: Container(
//       //           height: 10,
//       //           width: 10,
//       //           decoration: BoxDecoration(
//       //             color: CustomColors.grey11,
//       //             borderRadius: BorderRadius.circular(5),
//       //           ),
//       //         ));
//       //     }),
//       //   ),
//       // ),
      
// //        SizedBox(
// //   height: 170,
// //   child: PageView.builder(
// //     itemCount: products!.length,
// //     itemBuilder: (context, index) {
// //       final imageUrl = products[index].images?.isNotEmpty == true
// //           ? products[index].images!.first
// //           : demoImage;
// //       return Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 8),
// //         child: CustomImage.network(
// //           imageUrl,
// //           fit: BoxFit.cover,
// //           borderRadius: BorderRadius.circular(10),
// //         ),
// //       );
// //     },
// //   ),
// // ),

//             //   return
//             //    CustomImage.network(
//             //  //  demoImage,
//             //     products?[index+1].images?[index]?? demoImage,
//             //       width: double.infinity,
//             //       height: 170,
//             //       fit: BoxFit.fill);
         
          
// //           Obx(() {
// //   final products = homeController.allProducts;
// //   // if (products.isEmpty) {
// //   //   return Center(child: CircularProgressIndicator());
// //   // }
// //   final index = splashController.activeIndex.value;
// //   final image = (products.length > index+1 && products[index+1].images?.isNotEmpty == true)
// //       ? products[index+1].images!.first
// //       : demoImage;

// //   return CustomImage.network(
// //     image,
// //     width: double.infinity,
// //     height: 170,
// //     fit: BoxFit.fill,
// //   );
// // }),  
          
//           const SizedBox(height: 20),
//           SplashDots(),
//           const SizedBox(height: 20),
//           Container(
//             height: 70,
//             width: Get.width,
//             decoration: BoxDecoration(
//               color: CustomColors.babyblue,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Column(
//                   spacing: 7,
//                   children: [
//                     SizedBox(height: 5),
//                     Text(
//                       "Deal of the Day",
//                       style: TFonts.montFont(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: CustomColors.white),
//                     ),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.timer_outlined,
//                           color: CustomColors.white,
//                         ),
//                         Text(
//                           " 22h 55m 20s remaining ",
//                           style: TFonts.montFont(
//                               fontSize: 16, color: CustomColors.white),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//                 MainButton(
//                   onPressed: () {},
//                   title: "View All =>",
//                   width: 120,
//                   height: 30,
//                   withShadow: false,
//                   radius: 4,
//                   borderColor: CustomColors.white,
//                   backgroundColor: CustomColors.babyblue,
//                 ),
//               ],
//             ),
//           ),
      
//           const SizedBox(height: 20),
      
//           SizedBox(
//             height: 230,
//             child: ListView(
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               children: [
//                 ...List.generate(homeController.allProducts?.length ??0, (index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child:  cartWidget(
//                       [homeController.allProducts?[index].images?.first ?? "" ,
//                       homeController.allProducts?[index].title ?? "",
//                       homeController.allProducts?[index].description ?? "",
//                       homeController.allProducts?[index].price?.toString() ?? "",
//                       ],
//                       ),
//                   );
//                 })
//               ],
//             ),
//           ),
//           SizedBox(height: 20),
//           Row(
//             children: [
//               CustomImage.asset(
//                 "assets/images/offer.png",
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Special Offer",
//                         style: TFonts.montFont(
//                             fontSize: 18, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 10),
//                     Text(
//                         "We make sure you get the offer you need at best prices",
//                         softWrap: true,
//                         style: TFonts.montFont(
//                           fontSize: 14,
//                           color: CustomColors.grey11,
//                     ))
//                   ],
//                 ),
//               )
//             ],
//           ),
      
//           SizedBox(height: 20),
//           SizedBox(
//             height: 230,
//             child: ListView(
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               children: [
//                 ...List.generate(homeController.allProducts?.length ??0, (index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: cartWidget(
//                       [homeController.allProducts?[index].images?[0] ?? "" ,
//                       homeController.allProducts?[index].title ?? "",
//                       homeController.allProducts?[index].description ?? "",
//                       homeController.allProducts?[index].price?.toString() ?? "",
//                       ],
//                       ),
//                   );
//                 })
//               ],
//             ),
//           ),
//           SizedBox(height: 20),
      
//           Container(
//             height: 270,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: CustomColors.grey10,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomImage.asset("assets/images/sale.png",
//                     width: double.infinity, height: 200, fit: BoxFit.fill),
//                 SizedBox(height: 10),
//                 Text(" New Arrivals ",
//                     style: TFonts.montFont(
//                         fontSize: 18, fontWeight: FontWeight.bold)),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(" Summers’ 25 Collections ",
//                         style: TFonts.montFont(
//                           fontSize: 12,
//                         )),
//                     MainButton(
//                       onPressed: () {},
//                       title: "View All =>",
//                       width: 120,
//                       height: 30,
//                       withShadow: false,
//                       radius: 4,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
      
//           SizedBox(height: 20),
//           Container(
//             width: double.infinity,
//             height: 320,
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: CustomColors.grey10,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(" Sponserd",
//                     style: TFonts.montFont(
//                         fontSize: 18, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 10),
//                 CustomImage.asset("assets/images/shose2.png",
//                     width: double.infinity, height: 240, fit: BoxFit.fill),
//                 SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(" up to 50% Off",
//                         style: TFonts.montFont(
//                             fontSize: 15, fontWeight: FontWeight.bold)),
//                     Icon(
//                       Icons.arrow_forward_ios_outlined,
//                       size: 15,
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//     }
// }

//   Widget containerWidget(String title, Function() onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(2),
//         height: 25,
//         width: 50,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: CustomColors.grey7,
//         ),
//         child: Center(child: Text(title)),
//       ),
//     );
//   }

//   Widget categories(String image,  String name) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 15),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: () {
// Get.to(() => Scaffold(
//      // appBar: AppBar(title: Text(title ?? "Wishlist")),
//       body: WishlistBody(title: name),              ));
//             },
//             child: Container(
//               padding: const EdgeInsets.all(2),
//               height: 70,
//               width: 70,
//               child: CustomImage.network(image, height: 30, width: 30),
//             ),
//           ),
//           const SizedBox(height: 5),
//           Text(name, style: TFonts.montFont(fontSize: 12)),
//         ],
//       ),
//     );
//   }



// import 'package:ecommerce_app/data/const/export.dart';
// import 'package:ecommerce_app/data/data_sources/get_storage.dart';
// import 'package:ecommerce_app/data/remote_data/core.dart';
// import 'package:ecommerce_app/features/auth/domain/controller/auth_controller.dart';
// import 'package:ecommerce_app/features/home/domain/controller/home_controller.dart';
// import 'package:ecommerce_app/features/home/presentation/widget/items/cart_item.dart';
// import 'package:ecommerce_app/features/home/presentation/widget/wishlist_body.dart';
// import 'package:ecommerce_app/features/splash/domain/controller/splash_controller.dart';
// import 'package:ecommerce_app/features/splash/presentation/widget/splash_dots.dart';
// import 'package:ecommerce_app/res/configuration/text_field/text_field.dart';
// import 'package:ecommerce_app/res/router/pages.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class HomeBody extends StatelessWidget {
//   const HomeBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final HomeController homeController = Get.find<HomeController>();
//     final SplashController splashController = Get.find<SplashController>();
//     final AuthController authController = Get.find<AuthController>();

//     return 
//      GetBuilder<HomeController>(
//       builder: (controller) {
//         // Show loading indicator while data is being fetched
//         // if (controller.isLoading) {
//         //   return const Center(
//         //     child: CircularProgressIndicator(),
//         //   );
//         // }

// //final products = controller.allProducts;
//     final categories = controller.allCategories??[];
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
//           child: ListView(
//             children: [
//               // Greeting
//               Text(
//                 "Hello, ${authController.name ?? ''}",
//                 style: TFonts.montFont(fontSize: 20),
//               ),
        
//               const SizedBox(height: 10),
        
//               // Test Button
            
//               const SizedBox(height: 10),
        
//               // Logout
//               ElevatedButton(
//                 onPressed: () async {
//                   await sl<GetStorageData>().removeUser();
//                   Get.offAllNamed('/login');
//                 },
//                 child: const Text("تسجيل خروج"),
//               ),
        
//               const SizedBox(height: 10),
        
//               // Search Field
//               CustomTextField.searchField(
//                 hint: "Search any Products",
//                 (val) {},
//               ),
        
//               const SizedBox(height: 20),
        
//               // All Features Row
//               Row(
//                 children: [
//                   Text(
//                     "All Features",
//                     style: TFonts.montFont(
//                         fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const Spacer(),
//                   containerWidget("sort", () {}),
//                   const SizedBox(width: 10),
//                   containerWidget("filter", () {}),
//                 ],
//               ),
        
//               const SizedBox(height: 10),
        
//               // Categories Horizontal List
//               SizedBox(
//                 height: 140,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: CustomColors.grey10,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding: const EdgeInsets.all(10),
//                   child: categories.isEmpty
//                       ? const Center(
//                           child: Text("No categories available"))
//                       : ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: categories.length,
//                           itemBuilder: (context, index) {
//                             final cat = categories[index];
//                             return categoriess(
//                               cat.image ?? "",
//                               cat.name ?? "Unknown",
//                             );
//                           },
//                         ),
//                 ),
//               ),
        
//               const SizedBox(height: 20),
        
//               // Banner Slider (PageView)
//               SizedBox(
//                 height: 170,
//                 child: products.isEmpty
//                     ? Container(
//                         decoration: BoxDecoration(
//                           color: CustomColors.grey10,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Center(
//                           child: Text("No products available")),
//                       )
//                     : PageView.builder(
//                         onPageChanged: (index) {
//                           // Safely update the active index
//                           if (products.isNotEmpty) {
//                             splashController.activeIndex.value =
//                                 index % products.length;
//                           }
//                         },
//                         itemCount: products.length,
//                         itemBuilder: (context, index) {
//                           final product = products[index];
//                           final imageUrl = product.images?.isNotEmpty == true
//                               ? product.images!.first
//                               : demoImage;
        
//                           return Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 8),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: CustomImage.network(
//                                 imageUrl,
//                                 width: double.infinity,
//                                 height: 170,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//               ),
        
//               const SizedBox(height: 10),
        
//               // Dots Indicator (only show if products exist)
//               if (products.isNotEmpty) const SplashDots(),
        
//               const SizedBox(height: 20),
        
//               // Deal of the Day Banner
//               Container(
//                 height: 70,
//                 width: Get.width,
//                 decoration: BoxDecoration(
//                   color: CustomColors.babyblue,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Deal of the Day",
//                           style: TFonts.montFont(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: CustomColors.white),
//                         ),
//                         Row(
//                           children: [
//                             const Icon(Icons.timer_outlined,
//                                 color: CustomColors.white),
//                             Text(
//                               " 22h 55m 20s remaining ",
//                               style: TFonts.montFont(
//                                   fontSize: 16, color: CustomColors.white),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     MainButton(
//                       onPressed: () {},
//                       title: "View All =>",
//                       width: 120,
//                       height: 30,
//                       withShadow: false,
//                       radius: 4,
//                       borderColor: CustomColors.white,
//                       backgroundColor: CustomColors.babyblue,
//                     ),
//                   ],
//                 ),
//               ),
        
//               const SizedBox(height: 20),
        
//               // First Horizontal Product List
//               SizedBox(
//                 height: 230,
//                 child: products.isEmpty
//                     ? const Center(child: Text("No products available"))
//                     : ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: products.length,
//                         itemBuilder: (context, index) {
//                           final product = products[index];
//                           return Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: cartWidget([
//                               product.images?.firstOrNull ?? "",
//                               product.title ?? "No Title",
//                               product.description ?? "No Description",
//                               product.price?.toString() ?? "0",
//                             ]),
//                           );
//                         },
//                       ),
//               ),
        
//               const SizedBox(height: 20),
        
//               // Special Offer Section
//               Row(
//                 children: [
//                   CustomImage.asset("assets/images/offer.png"),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Special Offer",
//                           style: TFonts.montFont(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           "We make sure you get the offer you need at best prices",
//                           softWrap: true,
//                           style: TFonts.montFont(
//                             fontSize: 14,
//                             color: CustomColors.grey11,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
        
//               const SizedBox(height: 20),
        
//               // Flat and Heels Banner
//               Container(
//                 height: 150,
//                 decoration: BoxDecoration(
//                   color: CustomColors.grey10,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Row(
//                   children: [
//                     Stack(
//                       children: [
//                         Container(
//                           height: 150,
//                           width: 10,
//                           color: CustomColors.yellow,
//                         ),
//                         CustomImage.asset("assets/images/dots.png",
//                             height: 150),
//                         CustomImage.asset("assets/images/dots.png",
//                             height: 150, width: 150),
//                         Positioned(
//                           top: 5,
//                           left: 20,
//                           child: CustomImage.asset("assets/images/shose.png",
//                               width: 150, height: 150),
//                         ),
//                       ],
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 30, left: 20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Flat and Heels",
//                               style: TFonts.montFont(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               "Stand a chance to get rewarded",
//                               style: TFonts.montFont(
//                                   fontSize: 12, color: CustomColors.grey11),
//                             ),
//                             const SizedBox(height: 10),
//                             MainButton(
//                               onPressed: () {},
//                               title: "Visit Now =>",
//                               width: 130,
//                               height: 30,
//                               withShadow: false,
//                               radius: 4,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
        
//               const SizedBox(height: 20),
        
//               // Second Horizontal Product List
//               SizedBox(
//                 height: 230,
//                 child: products.isEmpty
//                     ? const Center(child: Text("No products available"))
//                     : ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: products.length,
//                         itemBuilder: (context, index) {
//                           final product = products[index];
//                           return Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: cartWidget([
//                               product.images?.firstOrNull ?? "",
//                               product.title ?? "No Title",
//                               product.description ?? "No Description",
//                               product.price?.toString() ?? "0",
//                             ]),
//                           );
//                         },
//                       ),
//               ),
        
//               const SizedBox(height: 20),
        
//               // New Arrivals
//               Container(
//                 height: 270,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: CustomColors.grey10,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomImage.asset("assets/images/sale.png",
//                         width: double.infinity,
//                         height: 200,
//                         fit: BoxFit.fill),
//                     const SizedBox(height: 10),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Text(
//                         "New Arrivals",
//                         style: TFonts.montFont(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Summers' 25 Collections",
//                             style: TFonts.montFont(fontSize: 12),
//                           ),
//                           MainButton(
//                             onPressed: () {},
//                             title: "View All =>",
//                             width: 120,
//                             height: 30,
//                             withShadow: false,
//                             radius: 4,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
        
//               const SizedBox(height: 20),
        
//               // Sponsored
//               Container(
//                 width: double.infinity,
//                 height: 320,
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: CustomColors.grey10,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Sponsored",
//                       style: TFonts.montFont(
//                           fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 10),
//                     CustomImage.asset("assets/images/shose2.png",
//                         width: double.infinity,
//                         height: 240,
//                         fit: BoxFit.fill),
//                     const SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "up to 50% Off",
//                           style: TFonts.montFont(
//                               fontSize: 15, fontWeight: FontWeight.bold),
//                         ),
//                         const Icon(Icons.arrow_forward_ios_outlined,
//                             size: 15),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
        
//               const SizedBox(height: 30),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Sort & Filter Button
//   Widget containerWidget(String title, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(2),
//         height: 25,
//         width: 50,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: CustomColors.grey7,
//         ),
//         child: Center(child: Text(title)),
//       ),
//     );
//   }

//   // Category Item
//   Widget categoriess(String image, String name) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: () {
//               Get.to(() => Scaffold(
//                     body: WishlistBody(title: name),
//                   ));
//             },
//             child: Container(
//               height: 70,
//               width: 70,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 5,
//                   ),
//                 ],
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: CustomImage.network(
//                   image,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 5),
//           Text(
//             name,
//             style: TFonts.montFont(fontSize: 12),
//             textAlign: TextAlign.center,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
// }
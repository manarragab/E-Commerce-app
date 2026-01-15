import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/data/data_sources/get_storage.dart';
import 'package:ecommerce_app/features/home/domain/controller/home_controller.dart';
import 'package:ecommerce_app/features/home/presentation/widget/items/cart_item.dart';
import 'package:ecommerce_app/features/home/presentation/widget/items/slider_item.dart';
import 'package:ecommerce_app/localization/arabicLang.dart';
import 'package:ecommerce_app/res/router/pages.dart';

class CartBody extends StatelessWidget {
   CartBody({Key? key}) : super(key: key);
 final isTapped = false.obs;
  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    final products = homeController.allProducts ?? [];

    // final sliderImages = products.map((product) {
    //   final imgs = product.images;
    //   return (imgs != null && imgs.isNotEmpty) ? imgs.last : "";
    // }).toList();

     final List<String> images = homeController.allProducts
            ?.map((product) =>
                (product.images != null &&
                        product.images!.isNotEmpty &&
                        product.images!.first.isNotEmpty)
                    ? product.images!.first
                    : null)
            .where((img) => img != null)
            .map((img) => img!)
            .toList() ??
        [];

 final allProducts=homeController.allProducts;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, ),
      child: 
      Obx((){
        
  final _ = homeController.activeIndex.value;

          String title = allProducts?[homeController.activeIndex.value].title ?? "Title";
          String desc = allProducts?[homeController.activeIndex.value].description ?? "desc";
          String price = allProducts?[homeController.activeIndex.value].price.toString() ?? "Title";
          
final product = homeController.allProducts?[homeController.activeIndex.value];
final List<String> similarImages = product?.images ?? [];
String currentImage= images[homeController.activeIndex.value];
final category= product?.category?.name ??"";

          return ListView(
          children: [
          SliderItem(
            images: images,
            length: images.length,
          ),
          SizedBox(height: 20,),

         Text(
            title.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10,),

          Row(
            children: [
          
          Text(
                "Price: ",
                style: TextStyle(
                  fontSize: 18,
             
                ),
              ),

              Text(
                " $price \$" ,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.primary,
                ),
              ),
            ],
          ),
           
           
          SizedBox(height: 10,),
          Text(
                "Product Description",
                style: TextStyle(
                  fontSize: 18,
             
                ),
              ),
              SizedBox(height: 10,),
          GestureDetector(
            onTap: () {
            isTapped.value = !isTapped.value;
            },
            child: Text( desc.length > 200 && isTapped.value==false ? "${desc.toString().substring(0, 190)}... More" : "${desc.toString()}",
            maxLines:desc.length > 200 && isTapped.value==false ?  4 : null,
             style: TextStyle(color: Colors.black,  fontWeight: FontWeight.bold, fontSize: 16,))
            ),

SizedBox(height: 20,),

Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
   actionButton(
  () {
   // homeController.wishlist.clear();
    bool exists = homeController.wishlist.any((item) => item["title"] == title && item["desc"] == desc);

    if (!exists) {
      homeController.wishlist.add({
        "title": title,
        "desc": desc,
        "price": price,
        "image": currentImage,
      });
           sl<GetStorageData>().setWishlist(homeController.wishlist);

      Get.snackbar(
        "Added to wishlist",
        "Item added to wishlist",
        backgroundColor: Colors.greenAccent,
        duration: const Duration(seconds: 2),
      );
    } else {
       Get.snackbar(
        "Already in wishlist",
        "Item in wishlist",
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 2),
      );
      print("Item already exists in wishlist");
    }

    print(homeController.wishlist);
  },
  "Wishlist",
  CustomColors.primary,
  Icon(Icons.favorite_outline),
  0,
  -20,
),

actionButton((){
Get.toNamed(CustomPage.shoppingPage , arguments: [ currentImage , title , desc , price ,category ]);
}, "Go To Buy", Colors.greenAccent,Icon(Icons.handshake_outlined) , 0, -25),
],),

          SizedBox(height: 10,),

             Text(
                "Details:",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            SizedBox(height: 10,),
         GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: similarImages.length,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 0.7,
  ),
  itemBuilder: (context, index) {
    return 
    
    ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CustomImage.network(
        similarImages[index],
        fit: BoxFit.cover,
      ),
    );
  },
),

        ],
      );
      }
     ),
    );
  }
Widget actionButton(
   VoidCallback onTap,
   String title,
   Color color,
   Widget icon,
  double top ,
  double left,
) {
  return SizedBox(
    height: 60,
    width: 130,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        MainButton(
          onPressed: onTap,
          title: title,
          height: 35,
          radius: 8,
          backgroundColor: color,
        ),
        Positioned(
          top: top,
          left: left,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromARGB(255, 68, 178, 125),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 68, 178, 125)
                      .withOpacity(0.5),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(child: icon),
          ),
        ),
      ],
    ),
  );
}
}



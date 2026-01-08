import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/data/data_sources/get_storage.dart';
import 'package:ecommerce_app/data/remote_data/core.dart';
import 'package:ecommerce_app/features/home/domain/controller/home_controller.dart';
import 'package:get_storage/get_storage.dart';
class WishlistBody extends StatefulWidget {
  final String? title;

  const WishlistBody({Key? key, this.title,}) : super(key: key);

  @override
  State<WishlistBody> createState() => _WishlistBodyState();
}

class _WishlistBodyState extends State<WishlistBody> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child:  Obx(() {
        return ListView.builder(
          itemCount: controller.wishlist.length,
          itemBuilder: (context, index) {
      final item = controller.wishlist[index];
      return Card(
  child: ListTile(
    leading: CustomImage.network(
      item["image"] ?? demoImage,
      height: 80,
      width: 80,
      fit: BoxFit.cover,
    ),
    title: Text(
      item["title"] ?? "",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          item["desc"] ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
    trailing: IconButton(
      icon: const Icon(Icons.delete),
      color: Colors.red,
      onPressed: () {
        controller.wishlist.removeAt(index);
        sl<GetStorageData>().setWishlist(controller.wishlist);

      },
    ),
  ),
);

          },
        );
      
        
        
      
      } )
    );
    
  }
}


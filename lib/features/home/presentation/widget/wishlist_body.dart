import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/data/data_sources/get_storage.dart';
import 'package:ecommerce_app/data/remote_data/core.dart';
import 'package:ecommerce_app/features/home/domain/controller/home_controller.dart';

class WishlistBody extends StatefulWidget {
  final String? title;

  const WishlistBody({Key? key, this.title}) : super(key: key);

  @override
  State<WishlistBody> createState() => _WishlistBodyState();
}

class _WishlistBodyState extends State<WishlistBody> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Obx(() {
        return ListView.builder(
          itemCount: controller.wishlist.length,
          itemBuilder: (context, index) {
            final item = controller.wishlist[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // الصورة
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CustomImage.network(
                        item["image"] ?? demoImage,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // النص
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item["title"] ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item["desc"] ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // زر الحذف
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        controller.wishlist.removeAt(index);
                        sl<GetStorageData>().setWishlist(controller.wishlist);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/features/home/domain/controller/home_controller.dart';
import 'package:ecommerce_app/features/home/presentation/widget/items/cart_item.dart';
import 'package:ecommerce_app/res/configuration/text_field/text_field.dart';
class SearchBody extends StatelessWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        final products = controller.filteredProducts;

        return SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField.searchField(
                hint: "Search Products", 
                (query) {
                  if(query.isEmpty) controller.removeProducts();
                  controller.searchProducts(query);
                },
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // reverse: true,
                  itemCount: products.length ,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return cartWidget(
                      height: 170,
                      image: product.images?.first ?? "",
                      title: product.title ?? "",
                      description: product.description ?? "",
                      price: product.price?.toString() ?? "",
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

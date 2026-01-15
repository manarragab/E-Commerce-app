import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/features/home/domain/controller/home_controller.dart';
import 'package:ecommerce_app/features/home/presentation/widget/items/cart_item.dart';
import 'package:ecommerce_app/res/configuration/text_field/text_field.dart';
class ProductsScreen extends StatefulWidget {

  const ProductsScreen({Key? key,}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final HomeController controller = Get.find<HomeController>();

final title = Get.arguments[1];
final valueKey = Get.arguments[0];
final id=Get.arguments[2];
  
  @override
  void initState() {
    super.initState();
    controller.initFilteredProducts(title:title );
    print("${title} ProductsScreen initState called");
  }

  @override
  Widget build(BuildContext context) {
print("valueKey is $valueKey"); 
    return Scaffold(
appBar: CustomAppBar.appBar(
  CustomTrans.products.tr,
),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: 
        GetBuilder<HomeController>(builder:( controller) {
          return
          ListView(
            children: [
              CustomTextField.searchField(
                controller: controller.searchController,
                hint: "Search any Products",
                (val) {
                 controller.searchProducts(val);
                },
              ),
      
        SizedBox(height: 10,),
            
       DropdownButton(
        menuWidth: 150,
        borderRadius: BorderRadius.circular(10),
      value: controller.selectedSort,
      autofocus: true,
      hint: Text("Sort"),
      items: const [
        DropdownMenuItem(
          value: "Default",
          child: Text("Default"),
        ),
        DropdownMenuItem(
          value: "L",
          child: Text("PriceLowToHigh"),
        ),
        DropdownMenuItem(
          value: "H",
          child: Text("PriceHighToLow"),
        ),
      ],
      
      onChanged: (value) {
        if (value  == "L") {
          controller.sortProductsAsend();
        } else if (value == "H") {
          controller.sortProductsDesc();
        } else if (value == "Default") {
          controller.resetProducts();
        }
        controller.selectedSort = value;
        controller.update();
      }, 
        ),
      
              SizedBox(height: 10,),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.filteredProducts.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = controller.filteredProducts?[index];
                  return cartWidget(
                    image: product?.images?.first ?? "",
                    title: product?.title ?? "",
                    description: product?.description ?? "",
                    price: id == "id" ? ((product?.price??0)*0.90).toString() : product?.price?.toString() ?? "",
                  );
                },
              ),
            ],
          );
        })
         
      ),
    );
    
  }
}



  // ✅ Sort / Filter Button
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

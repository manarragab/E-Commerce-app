import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/data/data_sources/get_storage.dart';
import 'package:ecommerce_app/data/models/categories/get/all_categories.dart';
import 'package:ecommerce_app/data/models/products/get/all_products.dart';
import 'package:ecommerce_app/domain_data/custom_mixin/custom_state_mixin.dart';
import 'package:ecommerce_app/features/home/domain/cases/home_case.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends MainGetxController with CustomStateMixin {
  
  RefreshController refreshController = RefreshController();

    @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }


RxList<Map<String, dynamic>> wishlist = <Map<String, dynamic>>[].obs;


  @override
  void onInit() {
    super.onInit();
    loadWishlist();
  }

  void loadWishlist() {
    final stored = sl<GetStorageData>().getWishlist();
    if (stored.isNotEmpty) {
wishlist.assignAll(
  List<Map<String, dynamic>>.from(stored),
);
    } 
  }


    int selectedIndex = 0;
     String? title;


     List<Icon> iconsList = [
    Icon(Icons.home),
    Icon(Icons.favorite),
    Icon(Icons.shopping_cart),
    Icon(Icons.search),
    Icon(Icons.settings),
  ];

  List<String> labelsList = [
    "Home",
    "Wishlist",
    "Cart",
    "Search",
    "Settings",
  ];

  RxInt activeIndex = 0.obs;

  void onItemTapped(int index , String? newTitle) {
      title = newTitle;
      selectedIndex = index;
      update();
  }

  TextEditingController searchController = TextEditingController();
  List<AllCategories>? allCategories;
  List<AllProducts>? allProducts;
  List<AllProducts> filteredProducts = [];


  void initFilteredProducts({String? title}) {
    filteredProducts = title == null
        ? allProducts ?? []
        : allProducts
                ?.where((product) => product.category?.name == title)
                .toList() ??
            [];
  }

  void searchProducts(String query) {
    filteredProducts = allProducts
        !.where((product) =>
            product.title?.toLowerCase().contains(query.toLowerCase()) ?? false)
        .toList();
    update(); 
  }

  void sortProductsAsend() {
    filteredProducts = List<AllProducts>.from(filteredProducts);
    filteredProducts.sort((a, b) => a.price!.compareTo(b.price!));
    update();
    print("Products sorted in ascending order");
  }

void sortProductsDesc() {
    filteredProducts = List<AllProducts>.from(filteredProducts);
    filteredProducts.sort((a, b) => b.price!.compareTo(a.price!));
    update();
  }

void resetProducts() {
  filteredProducts = List.from(allProducts!);
  update();
}

void removeProducts() {
  filteredProducts = [];
  update();
}
String? selectedSort;

 

  //   onRefresh() async {
  //   allCategories = (await refreshData(
  //       model: allCategories,
  //       futureMethod: () => sl<HomeCases>().allCategories(),
  //       controller: refreshController,
  //       getPage: (_) => _,
  //       checkIfEmpty: (data) {
  //         if (data is AllCategories) {
  //       if (data.categories?.isEmpty??true) {
  //         return AllCategories();
  //       }
  //     }
  //    return data;
  //       }))!;
  // }

  onRefreshn({bool force=false}) async {

if (!force && allCategories != null && allCategories!.isNotEmpty) {
  return;
}
    final res = await refreshData(
      model: allCategories,
      futureMethod: () => sl<HomeCases>().allCategories(),
      controller: refreshController,
      getPage: (r) => r,
      checkIfEmpty: (data) {
  if (data == null) return data;
  return data;
}
    );
    if (res != null) {
      allCategories = res ;
    }
    update();
  }

  Future<void> getAllCategories() async {
    loadingGetxController.showLoading();
    final response = await sl<HomeCases>().allCategories();
    print("📙 ResponseModel data: ${response.toJson()}");
       // loadingGetxController.hideLoading();

    if (response.data != null) {
      allCategories = response.data!;
    } else {
      print("❌ Failed to loaddd ${response.message}");
    }
    update();
  }

Future<void> getAllProducts() async {
    loadingGetxController.showLoading();
    final response = await sl<HomeCases>().allProducts();
    print("📙 ResponseModel products data: ${response.toJson()}");
       // loadingGetxController.hideLoading();
    if (response.data != null) {
      allProducts = response.data!;
      print("✅ Loaded ${allProducts!.first.title} ");
    } else {
      print("❌ Failed to load: ${response.message}");
    }
    update();
  }


}
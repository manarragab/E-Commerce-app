import 'package:ecommerce_app/data/models/categories/get/all_categories.dart';
import 'package:ecommerce_app/data/models/products/get/all_products.dart';
import 'package:ecommerce_app/data/remote_data/response_model.dart';
import 'package:ecommerce_app/domain_data/repositories/domain_repositry.dart';

class HomeCases {
  final DomainData _data;

  HomeCases(this._data);

  Future<ResponseModel<List<AllCategories>?>> allCategories() {
    return _data.allCategories();
  }

 Future<ResponseModel<List<AllProducts>?>> allProducts() {
    return _data.allProducts();
  }

}

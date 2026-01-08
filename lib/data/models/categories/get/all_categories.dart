
// class AllCategories{
//   List<Categories>? categories;

//   AllCategories({this.categories});

//   AllCategories.fromJson(Map<String, dynamic> json) {
//     categories = json["categories"] == null ? null : (json["categories"] as List).map((e) => Categories.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     if(categories != null) {
//       _data["categories"] = categories?.map((e) => e.toJson()).toList();
//     }
//     return _data;
//   }
// }

// class Categories {
//   String? id;
//   String? name;
//   String? description;
//   String? coverPictureUrl;

//   Categories({this.id, this.name, this.description, this.coverPictureUrl});

//   Categories.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     name = json["name"];
//     description = json["description"];
//     coverPictureUrl = json["coverPictureUrl"];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     _data["id"] = id;
//     _data["name"] = name;
//     _data["description"] = description;
//     _data["coverPictureUrl"] = coverPictureUrl;
//     return _data;
//   }
// }





import 'package:ecommerce_app/data/remote_data/response_model.dart';

// class AllCategories  extends ResponseModel<Dataa> {
//   num? status;
//   String? message;
//   Dataa? data;

//   AllCategories({this.status, this.message, this.data});

//   AllCategories.fromJson(Map<String, dynamic> json) {
//     status = json["status"];
//     message = json["message"];
//     data = json["data"] == null ? null : Dataa.fromJson(json["data"]);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     _data["status"] = status;
//     _data["message"] = message;
//     if(data != null) {
//       _data["data"] = data?.toJson();
//     }
//     return _data;
//   }
// }

// class Dataa extends ResponseModel<Categories> {
//   List<Categories>? categories;

//   Dataa({this.categories});

//   Dataa.fromJson(Map<String, dynamic> json) {
//     categories = json["categories"] == null ? null : (json["categories"] as List).map((e) => Categories.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     if(categories != null) {
//       _data["categories"] = categories?.map((e) => e.toJson()).toList();
//     }
//     return _data;
//   }
// }

// class Categories {
//   String? id;
//   String? name;
//   String? description;
//   String? coverPictureUrl;

//   Categories({this.id, this.name, this.description, this.coverPictureUrl});

//   Categories.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     name = json["name"];
//     description = json["description"];
//     coverPictureUrl = json["coverPictureUrl"];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     _data["id"] = id;
//     _data["name"] = name;
//     _data["description"] = description;
//     _data["coverPictureUrl"] = coverPictureUrl;
//     return _data;
//   }
// }


class AllCategories {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? creationAt;
  String? updatedAt;

  AllCategories({this.id, this.name, this.slug, this.image, this.creationAt, this.updatedAt});

  AllCategories.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    slug = json["slug"];
    image = json["image"];
    creationAt = json["creationAt"];
    updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["slug"] = slug;
    _data["image"] = image;
    _data["creationAt"] = creationAt;
    _data["updatedAt"] = updatedAt;
    return _data;
  }
  @override
  String toString() {
    return 'AllCategories{id: $id, name: $name, slug: $slug, image: $image, creationAt: $creationAt, updatedAt: $updatedAt}';
  }
}
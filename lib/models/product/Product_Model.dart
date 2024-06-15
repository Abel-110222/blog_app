// ignore_for_file: file_names

import 'package:blog_app/models/category/categories_model.dart';
import 'package:blog_app/models/images_model.dart';
import 'package:blog_app/models/organization/organization_model.dart';

class ProductModel {
  String? id;
  String? name;
  String? description;
  String? status;
  int reviewCount;
  int maxQuantityByCart;
  String? updatedAt;
  String? createdAt;
  String? deletedAt;
  int rating;

  OrganizationModel? organization;
  List<Categories>? categories;
  List<ImagenModel>? images;

  ProductModel(
      {this.id,
      this.name,
      this.description = '',
      this.status = '',
      this.reviewCount = 0,
      this.maxQuantityByCart = 0,
      this.updatedAt = '',
      this.createdAt = '',
      this.deletedAt = '',
      this.rating = 0,
      this.organization,
      this.categories,
      this.images});
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        status: json["status"] ?? '',
        reviewCount: json["reviewCount"] ?? 0,
        maxQuantityByCart: json["maxQuantityByCart"] ?? 0,
        updatedAt: json["updatedAt"] ?? DateTime.now().toString(),
        createdAt: json["createdAt"] ?? DateTime.now().toString(),
        deletedAt: json["deletedAt"] ?? DateTime.now().toString(),
        rating: json["rating"] ?? 0,
        organization:
            json["organization"] == null ? null : OrganizationModel.fromJson(json["organization"]),
        categories: json["categories"] == null
            ? []
            : List<Categories>.from(json["categories"].map((x) => Categories.fromJson(x))),
        images: json["images"] == null
            ? null
            : List<ImagenModel>.from(json["images"].map((x) => ImagenModel.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "status": status,
        "reviewCount": reviewCount,
        "maxQuantityByCart": maxQuantityByCart,
        "updatedAt": updatedAt,
        "createdAt": createdAt,
        "deletedAt": deletedAt,
        "rating": rating,
        "organization": organization,
        "categories": categories,
        "images": images
      };
}


// import 'dart:convert';
// import 'package:http/http.dart' as http;

// List<Categories> categoriesFromJson(String str) =>
//     List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

// String categoriesToJson(List<Categories> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Categories {
//   String? id;
//   String? name;
//   String? imageUrl;
//   int totalProducts;
//   DateTime createdAt;
//   DateTime updatedAt;

//   Categories({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//     required this.totalProducts,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Categories.fromJson(Map<String, dynamic> json) {
//     try {
//       return Categories(
//         id: json["id"] ?? "",
//         name: json["name"] ?? "",
//         imageUrl: json["imageUrl"] ?? "",
//         totalProducts: int.parse(json["totalProducts"] ?? "0"),
//         createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
//         updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
//       );
//     } catch (e) {
//       print("Error parsing category: $e");
//       return Categories(
//         id: "",
//         name: "",
//         imageUrl: "",
//         totalProducts: 0,
//         createdAt: DateTime.now(),
//         updatedAt: DateTime.now(),
//       );
//     }
//   }

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "imageUrl": imageUrl,
//         "totalProducts": totalProducts,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//       };
// }

// Future<List<Categories>> fetchCategories() async {
//   const url = 'http://punto-de-reunion.vercel.app/api/categories';

//   try {
//     final response = await http.get(Uri.parse(url));

//     if (response.body.isNotEmpty) {
//       final jsonData = json.decode(response.body)['categories'];
//       List<Categories> categoriesList = [];

//       for (var item in jsonData) {
//         categoriesList.add(Categories.fromJson(item));
//       }

//       return categoriesList;
//     } else {
//       throw Exception('Failed to load categories: ${response.statusCode}');
//     }
//   } catch (e) {
//     throw Exception('Failed to load categories: $e');
//   }
// }

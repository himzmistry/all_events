import 'dart:convert';

List<CategoryModel> categoryModelFromMap(String str) =>
    List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromMap(x)));

class CategoryModel {
  String? category;
  String? data;
  bool selected;

  CategoryModel({this.category, this.data, this.selected = false});

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        category: json["category"],
        data: json["data"],
      );
}

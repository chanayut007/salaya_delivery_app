import 'package:equatable/equatable.dart';

class ListOfCategory extends Equatable {
  final int statusCode;
  final String statusMessage;
  final List<Category> categories;

  const ListOfCategory({
    required this.statusCode,
    required this.statusMessage,
    required this.categories
  });

  factory ListOfCategory.fromJson(Map<String, dynamic> json) {
    return ListOfCategory(
      statusCode: json['statusCode'],
      statusMessage: json['statusMessage'],
      categories: (json['data'].length != 0) ? List.from(json['data'].map((x) => Category.fromJson(x))) : []
    );
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, categories];

}

class Category extends Equatable {
  final String categoryId;
  final String categoryName;

  const Category({required this.categoryId, required this.categoryName});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'],
      categoryName: json['categoryName']
    );
  }

  @override
  List<Object?> get props => [categoryId, categoryName];
}
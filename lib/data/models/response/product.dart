import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductResponse extends Equatable {
  final int statusCode;
  final String statusMessage;
  final List<Product> products;

  const ProductResponse({required this.statusCode, required this.statusMessage, required this.products});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      statusCode: json['statusCode'],
      statusMessage: json['statusMessage'],
      products: (json['data'].length != 0) ? List.from(json['data'].map((x) => Product.fromJson(x))) : []
    );
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, products];
}

class Product extends Equatable {

  final String productId;
  final String productName;
  final String? images;
  final double pricePerUnit;

  const Product({
    required this.productId,
    required this.productName,
    this.images,
    required this.pricePerUnit
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      productName: json['productName'],
      images: json['images'],
      pricePerUnit: double.parse(json['pricePerUnit'].toString())
    );
  }

  toMap() {
    return {
      "productId": productId,
      "productName": productName,
      "images": images,
      "pricePerUnit": pricePerUnit
    };
  }

  @override
  List<Object?> get props => [productId, productName, images, pricePerUnit];
}
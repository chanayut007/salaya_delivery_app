import 'package:equatable/equatable.dart';

class ProductDetailResponse extends Equatable {

  final int statusCode;
  final String statusMessage;
  final ProductDetail productDetail;

  const ProductDetailResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.productDetail
  });

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailResponse(
      statusCode: json['statusCode'],
      statusMessage: json['statusMessage'],
      productDetail: ProductDetail.fromJson(json['data'])
    );
  }


  @override
  List<Object?> get props => throw UnimplementedError();
}

class ProductDetail extends Equatable {

  final String productId;
  final String productName;
  final String details;
  final String? images;
  final double pricePerUnit;

  const ProductDetail({
    required this.productId,
    required this.productName,
    required this.details,
    this.images,
    required this.pricePerUnit
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      productId: json['productId'],
      productName: json['productName'],
      details: json['details'],
      images: json['images'],
      pricePerUnit: double.parse(json['pricePerUnit'].toString())
    );
  }

  @override
  List<Object?> get props => [productId, productName, details, images, pricePerUnit];

}
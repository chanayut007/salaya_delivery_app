part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable{}

class GetProductDetailById extends ProductDetailEvent {
  final String productId;

  GetProductDetailById({required this.productId});

  @override
  List<Object?> get props => [productId];
}

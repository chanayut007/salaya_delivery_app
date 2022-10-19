part of 'product_detail_bloc.dart';

abstract class ProductDetailState extends Equatable {}

class ProductDetailInitial extends ProductDetailState {
  @override
  List<Object?> get props => [];
}

class ProductDetailLoading extends ProductDetailState {
  @override
  List<Object?> get props => [];
}

class ProductDetailLoaded extends ProductDetailState {

  final ProductDetail productDetail;

  ProductDetailLoaded({required this.productDetail});

  @override
  List<Object?> get props => [productDetail];
}

class ProductDetailError extends ProductDetailState {

  final String message;

  ProductDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}

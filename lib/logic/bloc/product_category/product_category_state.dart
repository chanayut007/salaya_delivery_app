part of 'product_category_bloc.dart';

abstract class ProductCategoryState extends Equatable {}

class ProductCategoryInitial extends ProductCategoryState {
  @override
  List<Object?> get props => [];
}

class ProductCategoryLoading extends ProductCategoryState {
  @override
  List<Object?> get props => [];
}

class ProductCategoryLoaded extends ProductCategoryState {

  final List<Product> products;

  ProductCategoryLoaded({required this.products});


  @override
  List<Object?> get props => [products];
}

class ProductCategoryError extends ProductCategoryState {
  final String message;

  ProductCategoryError({required this.message});

  @override
  List<Object?> get props => [message];

}

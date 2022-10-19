part of 'product_category_bloc.dart';

abstract class ProductCategoryEvent extends Equatable {}

class GetProductByCategoryId extends ProductCategoryEvent {
  final String categoryId;

  GetProductByCategoryId({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}

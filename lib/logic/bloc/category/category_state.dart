part of 'category_bloc.dart';

abstract class CategoryState extends Equatable{}

class CategoryInitial extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryLoading extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryLoaded extends CategoryState {

  final Category? categoryAllProduct;
  final Category? categoryCosmetics;
  final Category? categoryHealthCareEquipment;

  CategoryLoaded({
    this.categoryAllProduct,
    this.categoryCosmetics,
    this.categoryHealthCareEquipment
  });

  @override
  List<Object?> get props => [categoryAllProduct, categoryCosmetics, categoryHealthCareEquipment];
}

class CategoryError extends CategoryState {

  final String message;

  CategoryError({required this.message});

  @override
  List<Object?> get props => [message];

}

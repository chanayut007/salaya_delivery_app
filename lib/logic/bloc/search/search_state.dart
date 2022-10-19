part of 'search_bloc.dart';

abstract class SearchState extends Equatable {}

class SearchInitial extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoaded extends SearchState {

  final List<Product> products;

  SearchLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});

  @override
  List<Object?> get props => [message];
}

class NavigateToProductDetailPage extends SearchState {
  final String productId;

  NavigateToProductDetailPage({required this.productId});

  @override
  List<Object?> get props => [productId];
}

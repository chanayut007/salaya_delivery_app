part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable{}

class SearchProductLocal extends SearchEvent {
  @override
  List<Object?> get props => [];
}

class SearchProductByKeyword extends SearchEvent {

  final String keyword;

  SearchProductByKeyword({required this.keyword});

  @override
  List<Object?> get props => [keyword];
}

class SaveProductToLocal extends SearchEvent {

  final Product product;

  SaveProductToLocal({required this.product});

  @override
  List<Object?> get props => [product];
}

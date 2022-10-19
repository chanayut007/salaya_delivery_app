part of 'recommend_bloc.dart';

abstract class RecommendState extends Equatable{}

class RecommendInitial extends RecommendState {
  @override
  List<Object?> get props => [];
}

class RecommendLoading extends RecommendState {
  @override
  List<Object?> get props => [];
}

class RecommendLoaded extends RecommendState {

  final List<Product> products;

  RecommendLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class RecommendError extends RecommendState {

  final String message;

  RecommendError({required this.message});


  @override
  List<Object?> get props => [message];

}

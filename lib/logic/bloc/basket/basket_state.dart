part of 'basket_bloc.dart';

abstract class BasketState extends Equatable{}

class BasketLoading extends BasketState {
  @override
  List<Object?> get props => [];
}

class BasketLoaded extends BasketState {

  final List<BasketObject> items;

  BasketLoaded({this.items = const []});

  copyWith({
    List<BasketObject>? items
  }) {
    return BasketLoaded(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];

}

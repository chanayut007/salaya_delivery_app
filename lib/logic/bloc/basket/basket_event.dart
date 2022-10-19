part of 'basket_bloc.dart';

abstract class BasketEvent extends Equatable {}

class AddBasket extends BasketEvent {

  final int qty;
  final Product product;

  AddBasket({this.qty = 1, required this.product});

  @override
  List<Object?> get props => [qty, product];
}

class IncreaseBasket extends BasketEvent {

  final Product product;

  IncreaseBasket({required this.product});

  @override
  List<Object?> get props => [product];
}

class DecreaseBasket extends BasketEvent {

  final Product product;

  DecreaseBasket({required this.product});

  @override
  List<Object?> get props => [product];
}

class RemoveBasket extends BasketEvent {

  final Product product;

  RemoveBasket({required this.product});

  @override
  List<Object?> get props => [product];

}

class RemoveAllBasket extends BasketEvent {
  @override
  List<Object?> get props => [];

}

import 'package:equatable/equatable.dart';
import 'package:salaya_delivery_app/data/models/response/product.dart';

class BasketObject extends Equatable {
  final int qty;
  final Product product;

  const BasketObject({required this.qty, required this.product});

  copyWith({
    int? qty,
    Product? product
  }) {
    return BasketObject(
      qty: qty ?? this.qty,
      product: product ?? this.product
    );
  }

  @override
  List<Object?> get props => [qty, product];
}
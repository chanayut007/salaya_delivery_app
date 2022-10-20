import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String orderNo;
  final String customerName;
  final String customerPhone;
  final String address;
  final String? comment;
  final String shipTo;
  final String branchShipping;
  final DateTime date;
  final List<Item> items;

  const Order({
    required this.orderNo,
    required this.customerName,
    required this.customerPhone,
    required this.address,
    this.comment,
    required this.shipTo,
    required this.branchShipping,
    required this.date,
    required this.items
  });

  @override
  List<Object?> get props => [orderNo, customerName, customerPhone, address, comment, shipTo, branchShipping, date, items];

}

class Item extends Equatable {
  final String itemNo;
  final String itemName;
  final double pricePerUnit;
  final int qty;
  final double totalPrice;

  const Item({
    required this.itemNo,
    required this.itemName,
    required this.pricePerUnit,
    required this.qty,
    required this.totalPrice
  });

  @override
  List<Object?> get props => [itemNo, itemName, pricePerUnit, qty, totalPrice];
}
import 'package:equatable/equatable.dart';
import 'package:salaya_delivery_app/presentation/utils/date_format_extension.dart';

class CheckoutResponse extends Equatable {
  final int statusCode;
  final String statusMessage;
  final Checkout checkout;

  const CheckoutResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.checkout
  });

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutResponse(
      statusCode: json['statusCode'],
      statusMessage: json['statusMessage'],
      checkout: Checkout.fromJson(json['data'])
    );
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, checkout];
}

class Checkout extends Equatable {
  final String orderNo;
  final DateTime checkoutDate;

  const Checkout({required this.orderNo, required this.checkoutDate});

  factory Checkout.fromJson(Map<String, dynamic> json) {
    return Checkout(
      orderNo: json['orderNo'],
      checkoutDate: getDateFromString(json['checkoutDate'])
    );
  }

  @override
  List<Object?> get props => [orderNo, checkoutDate];
}
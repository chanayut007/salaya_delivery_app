part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable{}

class CheckoutLoading extends CheckoutState {
  @override
  List<Object?> get props => [];
}

class CheckoutLoaded extends CheckoutState {

  final ShippingType? shippingType;
  final String? branchShipping;
  final String? address;
  final String? comment;
  final String? fullName;
  final String? phoneNumber;

  CheckoutLoaded({
    this.shippingType,
    this.branchShipping,
    this.address,
    this.comment,
    this.fullName,
    this.phoneNumber
  });

  copyWith({
    ShippingType? shippingType,
    String? address,
    String? branchShipping,
    String? comment,
    String? fullName,
    String? phoneNumber
  }) {
    return CheckoutLoaded(
      shippingType: shippingType ?? this.shippingType,
      address: address ?? this.address,
      comment: comment ?? this.comment,
      branchShipping: branchShipping ?? this.branchShipping,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber
    );
  }


  @override
  List<Object?> get props => [shippingType, address, comment, branchShipping, fullName, phoneNumber];
}

class CheckoutApiLoading extends CheckoutState {
  @override
  List<Object?> get props => [];
}

class CheckoutApiSuccess extends CheckoutState {
  @override
  List<Object?> get props => [];
}

class CheckoutApiError extends CheckoutState {

  final String message;

  CheckoutApiError({required this.message});

  @override
  List<Object?> get props => [message];
}

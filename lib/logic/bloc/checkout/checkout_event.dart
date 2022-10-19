part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {}

class SetShipping extends CheckoutEvent {

  final ShippingType shippingType;

  SetShipping({required this.shippingType});

  @override
  List<Object?> get props => [shippingType];
}

class SetBranch extends CheckoutEvent {

  final String branchId;

  SetBranch({required this.branchId});

  @override
  List<Object?> get props => [branchId];

}

class EditAddressTextField extends CheckoutEvent {

  final String text;

  EditAddressTextField({required this.text});

  @override
  List<Object?> get props => [text];
}

class EditCommentTextField extends CheckoutEvent {

  final String text;

  EditCommentTextField({required this.text});

  @override
  List<Object?> get props => [text];
}

class EditFullNameTextField extends CheckoutEvent {

  final String text;

  EditFullNameTextField({required this.text});

  @override
  List<Object?> get props => [text];
}

class EditPhoneNumberTextField extends CheckoutEvent {

  final String text;

  EditPhoneNumberTextField({required this.text});

  @override
  List<Object?> get props => [text];
}

class ClickButtonCheckout extends CheckoutEvent {

  final List<BasketObject> baskets;

  ClickButtonCheckout({required this.baskets});

  @override
  List<Object?> get props => [baskets];
}

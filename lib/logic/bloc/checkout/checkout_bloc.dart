import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:salaya_delivery_app/data/models/basket_object.dart';
import 'package:salaya_delivery_app/data/models/request/checkout_request.dart';
import 'package:salaya_delivery_app/data/models/request/item_request.dart';
import 'package:salaya_delivery_app/data/models/response/product.dart';
import 'package:salaya_delivery_app/data/models/shipping_type.dart';
import 'package:salaya_delivery_app/data/repositories/remote/remote_checkout_repository.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {

  final RemoteCheckoutRepository remoteCheckoutRepository;
  final ShippingType shippingType;

  CheckoutBloc({required this.remoteCheckoutRepository, required this.shippingType}) : super(CheckoutLoaded(shippingType: shippingType)) {
    on<SetBranch>(_onSetBranch);

    on<EditAddressTextField>(_onEditAddressTextField);
    on<EditCommentTextField>(_onEditCommentTextField);
    on<EditFullNameTextField>(_onEditFullNameTextField);
    on<EditPhoneNumberTextField>(_onEditPhoneNumberTextField);

    on<ClickButtonCheckout>(_onClickButtonCheckout);

  }

  void _onSetBranch(SetBranch event, Emitter<CheckoutState> state) {
    final state = this.state as CheckoutLoaded;
    emit(CheckoutLoading());
    emit(state.copyWith(branchShipping: event.branchId));
  }

  void _onEditAddressTextField(EditAddressTextField event, Emitter<CheckoutState> state) {
    final state = this.state as CheckoutLoaded;
    emit(CheckoutLoading());
    emit(state.copyWith(address: event.text));
  }

  void _onEditCommentTextField(EditCommentTextField event, Emitter<CheckoutState> state) {
    final state = this.state as CheckoutLoaded;
    emit(CheckoutLoading());
    emit(state.copyWith(comment: event.text));
  }

  void _onEditFullNameTextField(EditFullNameTextField event, Emitter<CheckoutState> state) {
    final state = this.state as CheckoutLoaded;
    emit(CheckoutLoading());
    emit(state.copyWith(fullName: event.text));
  }

  void _onEditPhoneNumberTextField(EditPhoneNumberTextField event, Emitter<CheckoutState> state) {
    final state = this.state as CheckoutLoaded;
    emit(CheckoutLoading());
    emit(state.copyWith(phoneNumber: event.text));
  }

  void _onClickButtonCheckout(ClickButtonCheckout event, Emitter<CheckoutState> state) async {
    final state = this.state as CheckoutLoaded;
    try {
      emit(CheckoutApiLoading());

      List<ItemRequest> items = [];
      for (BasketObject basket in event.baskets) {
        final item = ItemRequest(
            itemNo: basket.product.productId,
            itemName: basket.product.productName,
            qty: basket.qty,
            pricePerUnit: basket.product.pricePerUnit
        );
        items.add(item);
      }

      bool isSuccess = await remoteCheckoutRepository.checkout(
          CheckoutRequest(
            customerName: state.fullName!,
            customerPhone: state.phoneNumber!,
            customerComment: state.comment,
            address: state.address!,
            shipTo: (state.shippingType == ShippingType.SHIPPING) ? "S" : "D" ,
            branchShipping: state.branchShipping!,
            items: items
          )
      );

      emit(CheckoutApiSuccess());
    } catch (ex) {
      emit(CheckoutApiError(message: ex.toString()));
      emit(state);
    }
  }

}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:salaya_delivery_app/data/models/basket_object.dart';
import 'package:salaya_delivery_app/data/models/response/product.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(BasketLoaded()) {
    on<AddBasket>(_onAddBasket);
    on<IncreaseBasket>(_onIncreaseBasket);
    on<DecreaseBasket>(_onDecreaseBasket);
    on<RemoveBasket>(_onRemoveBasket);
    on<RemoveAllBasket>(_onRemoveAllBasket);

  }

  void _onAddBasket(AddBasket event, Emitter<BasketState> state) {
    final state = this.state as BasketLoaded;
    emit(BasketLoading());
    List<BasketObject> items = state.items;

    final isSuccess = items.map((item) => item.product == event.product).toList();
    debugPrint('list: ${isSuccess.length}');

    if (isSuccess.isEmpty) {
      BasketObject item = BasketObject(qty: event.qty, product: event.product);
      emit(BasketLoaded(items: [item]));

    }
    else if (isSuccess.contains(true)) {
      BasketObject item = items.firstWhere((item) => item.product == event.product);
      int itemIndex = items.indexOf(item);
      int increaseQty = item.qty + event.qty;
      items[itemIndex] = item.copyWith(qty: increaseQty);
      debugPrint("items: $items");
      emit(BasketLoaded(items: items));

    } else {
      BasketObject item = BasketObject(qty: event.qty, product: event.product);
      items.add(item);
      emit(BasketLoaded(items: items));

    }
  }

  void _onIncreaseBasket(IncreaseBasket event, Emitter<BasketState> state) {
    final state = this.state as BasketLoaded;
    emit(BasketLoading());

    List<BasketObject> items = state.items;

    BasketObject item = items.firstWhere((item) => item.product == event.product);
    int itemIndex = items.indexOf(item);
    int increaseQty = item.qty + 1;
    items[itemIndex] = item.copyWith(qty: increaseQty);
    emit(BasketLoaded(items: items));
  }

  void _onDecreaseBasket(DecreaseBasket event, Emitter<BasketState> state) {
    final state = this.state as BasketLoaded;
    emit(BasketLoading());

    List<BasketObject> items = state.items;

    BasketObject item = items.firstWhere((item) => item.product == event.product);
    int itemIndex = items.indexOf(item);
    int decreaseQty = item.qty - 1;
    items[itemIndex] = item.copyWith(qty: decreaseQty);
    emit(BasketLoaded(items: items));

  }

  void _onRemoveBasket(RemoveBasket event, Emitter<BasketState> state) {
    final state = this.state as BasketLoaded;
    emit(BasketLoading());

    List<BasketObject> items = state.items;
    items.removeWhere((value) => value.product == event.product);
    emit(BasketLoaded(items: items));
  }

  void _onRemoveAllBasket(RemoveAllBasket event, Emitter<BasketState> state) {
    emit(BasketLoading());
    List<BasketObject> baskets = [];
    emit(BasketLoaded(items: baskets));
  }
}

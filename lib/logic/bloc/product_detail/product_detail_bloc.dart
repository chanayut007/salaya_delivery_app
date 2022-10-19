import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:salaya_delivery_app/data/models/response/product_detail.dart';
import 'package:salaya_delivery_app/data/repositories/remote/remote_product_repository.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {

  final RemoteProductRepository remoteProductRepository;

  ProductDetailBloc({required this.remoteProductRepository}) : super(ProductDetailInitial()) {
    on<GetProductDetailById>(_onGetProductDetailById);
  }

  void _onGetProductDetailById(GetProductDetailById event, Emitter<ProductDetailState> state) async {
    try {
      emit(ProductDetailLoading());
      ProductDetail result = await remoteProductRepository.getProductDetailById(event.productId);
      emit(ProductDetailLoaded(productDetail: result));
    } catch (ex) {
      emit(ProductDetailError(message: ex.toString()));
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:salaya_delivery_app/data/models/response/product.dart';
import 'package:salaya_delivery_app/data/repositories/remote/remote_product_repository.dart';

part 'product_category_event.dart';
part 'product_category_state.dart';

class ProductCategoryBloc extends Bloc<ProductCategoryEvent, ProductCategoryState> {

  final RemoteProductRepository remoteProductRepository;

  ProductCategoryBloc({required this.remoteProductRepository}) : super(ProductCategoryInitial()) {
    on<GetProductByCategoryId>(_onGetProductByCategoryId);

  }

  void _onGetProductByCategoryId(GetProductByCategoryId event, Emitter<ProductCategoryState> state) async {
    try {
      emit(ProductCategoryLoading());
      List<Product> products = await remoteProductRepository.getProductByCategoryId(event.categoryId);
      emit(ProductCategoryLoaded(products: products));
    } catch (ex) {
      emit(ProductCategoryError(message: ex.toString()));
    }
  }
}

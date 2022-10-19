import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:salaya_delivery_app/data/models/response/product.dart';
import 'package:salaya_delivery_app/data/repositories/local/local_product_repository.dart';
import 'package:salaya_delivery_app/data/repositories/remote/remote_product_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final RemoteProductRepository remoteProductRepository;
  final LocalProductRepository localProductRepository;

  SearchBloc({required this.remoteProductRepository, required this.localProductRepository}) : super(SearchInitial()) {
    on<SearchProductLocal>(_onSearchProductLocal);
    on<SearchProductByKeyword>(_onSearchProductByKeyword);
    on<SaveProductToLocal>(_onSaveProductToLocal);

  }

  void _onSearchProductLocal(SearchProductLocal event, Emitter<SearchState> state) async {
    try {
      emit(SearchLoading());
      List<Product> products = [];
      products = localProductRepository.getProductSearch();
      if (products.isEmpty) {
        products = await remoteProductRepository.getProductByCategoryId("all");
      }
      emit(SearchLoaded(products: products));
    } catch (ex) {
      emit(SearchError(message: ex.toString()));
    }
  }

  void _onSearchProductByKeyword(SearchProductByKeyword event, Emitter<SearchState> state) async {
    try {
      emit(SearchLoading());
      List<Product> products = await remoteProductRepository.searchProductByName(event.keyword);
      emit(SearchLoaded(products: products));
    } catch (ex) {
      emit(SearchError(message: ex.toString()));
    }
  }

  void _onSaveProductToLocal(SaveProductToLocal event, Emitter<SearchState> state) async {
    final state = this.state as SearchLoaded;
    emit(SearchLoading());
    await localProductRepository.setProductSearch(event.product);
    emit(NavigateToProductDetailPage(productId: event.product.productId));
    emit(state);
  }
}

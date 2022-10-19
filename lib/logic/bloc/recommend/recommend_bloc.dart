import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:salaya_delivery_app/data/models/response/product.dart';
import 'package:salaya_delivery_app/data/repositories/remote/remote_product_repository.dart';

part 'recommend_event.dart';
part 'recommend_state.dart';

class RecommendBloc extends Bloc<RecommendEvent, RecommendState> {

  final RemoteProductRepository remoteProductRepository;

  RecommendBloc({required this.remoteProductRepository}) : super(RecommendInitial()) {
    on<GetProductRecommend>(_onGetProductRecommend);
  }

  void _onGetProductRecommend(GetProductRecommend event, Emitter<RecommendState> state) async {
    try {
      emit(RecommendLoading());
      List<Product> result = await remoteProductRepository.getProductRecommend();
      emit(RecommendLoaded(products: result));
    } catch (ex) {
      emit(RecommendError(message: ex.toString()));
    }
  }
}

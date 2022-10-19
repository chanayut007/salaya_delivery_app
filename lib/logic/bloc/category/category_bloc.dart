import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:salaya_delivery_app/data/models/response/category.dart';
import 'package:salaya_delivery_app/data/repositories/remote/remote_category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  final RemoteCategoryRepository remoteCategoryRepository;

  CategoryBloc({required this.remoteCategoryRepository}) : super(CategoryInitial()) {
    on<GetCategory>(_onGetCategory);
  }

  void _onGetCategory(GetCategory event, Emitter<CategoryState> state) async {
    try {
      emit(CategoryLoading());
      List<Category> listOfCategory = await remoteCategoryRepository.getAllCategory();
      Category? categoryCosmetics = listOfCategory.firstWhere((value) => value.categoryName == "เวชสำอาง");
      Category? categoryHealthCareEquipment = listOfCategory.firstWhere((value) => value.categoryName == "อุปกรณ์ดูแลสุขภาพ");
      emit(CategoryLoaded(
        categoryAllProduct: const Category(categoryId: 'all', categoryName: 'สินค้าทั้งหมด'),
        categoryCosmetics: categoryCosmetics,
        categoryHealthCareEquipment: categoryHealthCareEquipment
      ));
    } catch (ex) {
      emit(CategoryError(message: ex.toString()));
    }
  }
}

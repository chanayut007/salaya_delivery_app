part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent extends Equatable{}

class GetCategory extends CategoryEvent {

  @override
  List<Object?> get props => [];
}

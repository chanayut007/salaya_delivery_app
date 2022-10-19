part of 'branch_bloc.dart';

abstract class BranchState extends Equatable{}

class BranchInitial extends BranchState {
  @override
  List<Object?> get props => [];
}

class BranchLoading extends BranchState {
  @override
  List<Object?> get props => [];
}

class BranchLoaded extends BranchState {

  final Branch branch;

  BranchLoaded({required this.branch});

  @override
  List<Object?> get props => [branch];
}

class BranchError extends BranchState {

  final String message;

  BranchError({required this.message});

  @override
  List<Object?> get props => [message];

}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:salaya_delivery_app/data/models/response/branch.dart';
import 'package:salaya_delivery_app/data/repositories/remote/remote_branch_repository.dart';

part 'branch_event.dart';
part 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {

  final RemoteBranchRepository remoteBranchRepository;

  BranchBloc({required this.remoteBranchRepository}) : super(BranchInitial()) {
    on<GetBranchShipping>(_onGetBranchShipping);
  }

  void _onGetBranchShipping(GetBranchShipping event, Emitter<BranchState> state) async {
    try {
      emit(BranchLoading());
      Branch result = await remoteBranchRepository.getBranchNearBy();
      emit(BranchLoaded(branch: result));
    } catch (ex) {
      emit(BranchError(message: ex.toString()));
    }
  }
}

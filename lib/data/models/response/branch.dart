import 'package:equatable/equatable.dart';

class BranchResponse extends Equatable {

  final int statusCode;
  final String statusMessage;
  final Branch branch;

  const BranchResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.branch
  });

  factory BranchResponse.fromJson(Map<String, dynamic> json) {
    return BranchResponse(
      statusCode: json['statusCode'],
      statusMessage: json['statusMessage'],
      branch: Branch.fromJson(json['data'])
    );
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, branch];
}

class Branch extends Equatable {

  final String branchId;
  final String branchName;

  const Branch({required this.branchId, required this.branchName});

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      branchId: json['branchId'],
      branchName: json['branchName']
    );
  }

  @override
  List<Object?> get props => [branchId, branchName];

}
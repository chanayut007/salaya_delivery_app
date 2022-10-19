import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salaya_delivery_app/core/constants/value_constant.dart';
import 'package:salaya_delivery_app/data/models/response/branch.dart';

class RemoteBranchRepository {

  late String _endpointUrl;
  late Duration _timeout;

  RemoteBranchRepository() {
    _endpointUrl = ValueConstant.baseUrl + "/branch";
    _timeout = const Duration(seconds: 20);
  }

  Future<Branch> getBranchNearBy() async {
    try {
      String path = "/nearby?latitude=102&longitude=102";
      final url = Uri.parse(_endpointUrl + path);
      final response = await http.get(url).timeout(_timeout);
      BranchResponse responseObj = BranchResponse.fromJson(jsonDecode(response.body));
      return responseObj.branch;
    } catch (ex) {
      throw Exception(ex);
    }
  }


}
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salaya_delivery_app/core/constants/value_constant.dart';
import 'package:salaya_delivery_app/data/models/response/category.dart';

class RemoteCategoryRepository {

  late String _endpointUrl;
  late Duration _timeout;

  RemoteCategoryRepository() {
    _endpointUrl = ValueConstant.baseUrl + "/category";
    _timeout = const Duration(seconds: 20);
  }

  Future<List<Category>> getAllCategory() async {
    try {
      final url = Uri.parse(_endpointUrl);
      final response = await http.get(url).timeout(_timeout);
      ListOfCategory responseObj = ListOfCategory.fromJson(jsonDecode(response.body));
      return responseObj.categories;
    } catch (ex) {
      throw Exception(ex);
    }
  }

}
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:salaya_delivery_app/core/constants/value_constant.dart';
import 'package:salaya_delivery_app/data/models/request/checkout_request.dart';

class RemoteCheckoutRepository {

  late String _endpointUrl;
  late Duration _timeout;
  late Map<String, String> _headers;

  RemoteCheckoutRepository() {
    _endpointUrl = ValueConstant.baseUrl + "/checkout";
    _timeout = const Duration(seconds: 20);
    _headers = {
      "Content-Type": "application/json"
    };
  }

  Future<bool> checkout(CheckoutRequest request) async {
    try {
      final url = Uri.parse(_endpointUrl);
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode(request.toMap())
      ).timeout(_timeout);

      if (response.statusCode == HttpStatus.created) {
        return true;
      } else {
        return false;
      }
    } catch (ex) {
      throw Exception(ex);
    }
  }

}
import 'dart:convert';

import 'package:salaya_delivery_app/core/constants/value_constant.dart';
import 'package:salaya_delivery_app/data/models/response/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalProductRepository {

  late SharedPreferences prefs;

  LocalProductRepository({required this.prefs});
  
  List<Product> getProductSearch() {
    final response = prefs.getString(ValueConstant.keywordProduct);
    if (response != null) {
      final result = (json.decode(response) as List<dynamic>).map((json) => Product.fromJson(json)).toList();
      return result;
    }
    return [];
  }
  
  Future<void> setProductSearch(Product product) async {
    List<Product> data = getProductSearch();
    if (data.isNotEmpty) {
      if (!data.contains(product)) {
        data.add(product);
      }
      final products = data.map((item) => item.toMap()).toList();
      await prefs.setString(ValueConstant.keywordProduct, json.encode(products));
    }
    else {
      final products = [product.toMap()];
      await prefs.setString(ValueConstant.keywordProduct, json.encode(products));
    }
  }

}
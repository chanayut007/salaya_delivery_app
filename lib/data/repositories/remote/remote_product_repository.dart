import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salaya_delivery_app/core/constants/value_constant.dart';
import 'package:salaya_delivery_app/data/models/response/product.dart';
import 'package:salaya_delivery_app/data/models/response/product_detail.dart';

class RemoteProductRepository {

  late String _endpointUrl;
  late Duration _timeout;

  RemoteProductRepository() {
    _endpointUrl = ValueConstant.baseUrl + "/products";
    _timeout = const Duration(seconds: 20);
  }

  Future<List<Product>> getProductRecommend() async {
    try {
      String path = "/recommend";
      final url = Uri.parse(_endpointUrl + path);
      final response = await http.get(url).timeout(_timeout);
      ProductResponse responseObj = ProductResponse.fromJson(jsonDecode(response.body));
      return responseObj.products;
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List<Product>> getProductByCategoryId(String categoryId) async {
    try {
      String path = "/category/$categoryId";
      final url = Uri.parse(_endpointUrl + path);
      final response = await http.get(url).timeout(_timeout);
      ProductResponse responseObj = ProductResponse.fromJson(jsonDecode(response.body));
      return responseObj.products;
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List<Product>> searchProductByName(String keyword) async {
    try {
      String path = "/search?name=$keyword";
      final url = Uri.parse(_endpointUrl + path);
      final response = await http.get(url).timeout(_timeout);
      ProductResponse responseObj = ProductResponse.fromJson(jsonDecode(response.body));
      return responseObj.products;
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<ProductDetail> getProductDetailById (String productId) async {
    try {
      String path = "/$productId/details";
      final url = Uri.parse(_endpointUrl + path);
      final response = await http.get(url).timeout(_timeout);
      ProductDetailResponse responseObj = ProductDetailResponse.fromJson(jsonDecode(response.body));
      return responseObj.productDetail;
    } catch (ex) {
      throw Exception(ex);
    }
  }

}
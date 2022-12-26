import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_bakers/Services/constant.dart';

import '../Models/product_model.dart';

class ProductService {
  Future<ProductModel> getChapter() async {
    final body = {
      'var_vendor_id': '88',
    };

    final response = await http
        .post(Uri.parse(ApiUrl.baseurl + ApiUrl.endPoint), body: body);
    if (response.statusCode == 200) {
      String data = response.body;

      return ProductModel.fromJson(json.decode(data));
    } else {
      throw Exception('Failed to get chapter data');
    }
  }
}

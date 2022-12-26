import 'package:flutter/material.dart';

import '../Models/product_model.dart';
import '../Services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final _service = ProductService();
  bool isLoading = false;
  ProductModel? _productModel;
  ProductModel? get productList => _productModel;

  Future<void> getProducts() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getChapter();

    _productModel = response;
    isLoading = false;
    notifyListeners();
  }
}

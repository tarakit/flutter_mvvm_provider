import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_provider/data/response/api_response.dart';
import 'package:flutter_mvvm_provider/models/product.dart';
import 'package:flutter_mvvm_provider/repository/home_repository.dart';

class HomeViewModel extends ChangeNotifier{
    final _productRepository = ProductRepository();
    ApiResponse<ProductModel> apiResponse = ApiResponse.loading();

    setProductList(ApiResponse<ProductModel> response) {
      apiResponse = response;
      notifyListeners();
    }

    Future<dynamic> getProducts(page, limit) async {
      setProductList(ApiResponse.loading());
      await _productRepository.getProducts(page, limit).then((productList) {
        print('success');
        setProductList(ApiResponse.complete(productList));
      }).onError((error, stackTrace) {
        print('error ${error.toString()}');
        setProductList(ApiResponse.error(error.toString()));
      });
    }
}
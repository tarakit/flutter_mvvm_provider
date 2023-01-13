import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_provider/data/response/api_response.dart';
import 'package:flutter_mvvm_provider/models/image_response.dart';
import 'package:flutter_mvvm_provider/models/product.dart';
import 'package:flutter_mvvm_provider/repository/home_repository.dart';

class HomeViewModel extends ChangeNotifier{
    final _productRepository = ProductRepository();

    ApiResponse<ProductModel> apiResponse = ApiResponse.loading();
    ApiResponse<ImageResponse> imageResponse = ApiResponse.loading();

    setImageResponse(ApiResponse<ImageResponse> response){
      imageResponse = response;
      notifyListeners();
    }

    setProductList(ApiResponse<ProductModel> response) {
      apiResponse = response;
      notifyListeners();
    }

    Future<dynamic> uploadImage(file) async {
      await _productRepository.uploadImage(file).then((image) => {
        setImageResponse(ApiResponse.complete(image))
      }).onError((error, stackTrace) => {
        setImageResponse(ApiResponse.error(error.toString()))
      });
    }

    Future<dynamic> getProducts(page, limit) async {
      // setProductList(ApiResponse.loading());
      await _productRepository.getProducts(page, limit).then((productList) {
        print('success');
        setProductList(ApiResponse.complete(productList));
      }).onError((error, stackTrace) {
        print('error ${error.toString()}');
        setProductList(ApiResponse.error(error.toString()));
      });
    }
}
import 'package:flutter_mvvm_provider/data/network/network_api_service.dart';
import 'package:flutter_mvvm_provider/models/product.dart';
import 'package:flutter_mvvm_provider/res/app_url.dart';

class ProductRepository {

  final _apiService = NetworkApiService();

  Future<ProductModel> getProducts() async {
    try{
      print('before converting object ');
      dynamic response = await _apiService.getApiResponse(AppUrl.products);
      return response = ProductModel.fromJson(response);
      print(ProductModel.fromJson(response));

    }catch(error){
      rethrow;
    }
  }


}
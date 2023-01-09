import 'package:flutter_mvvm_provider/data/network/network_api_service.dart';
import 'package:flutter_mvvm_provider/models/product.dart';
import 'package:flutter_mvvm_provider/res/app_url.dart';

class ProductRepository {

  final _apiService = NetworkApiService();

  Future<ProductModel> getProducts(page, limit) async {
    try{
      print('before converting object ');
      var url = '${AppUrl.products}&pagination%5Bpage%5D=$page&pagination%5BpageSize%5D=$limit';
      dynamic response = await _apiService
          .getApiResponse(url);
      print('url $url');

      return response = ProductModel.fromJson(response);


    }catch(error){
      rethrow;
    }
  }


}
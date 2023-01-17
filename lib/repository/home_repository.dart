import 'package:flutter_mvvm_provider/data/network/network_api_service.dart';
import 'package:flutter_mvvm_provider/models/image_response.dart';
import 'package:flutter_mvvm_provider/models/product.dart';
import 'package:flutter_mvvm_provider/models/product_request.dart';
import 'package:flutter_mvvm_provider/res/app_url.dart';

class ProductRepository {

  final _apiService = NetworkApiService();

  Future postProduct(dataRequest) async {
    try{
        var product = ProductRequest(data: dataRequest);
        var response = await _apiService.postApi(AppUrl.products, product.toJson());
        // ជំពាក់ response
    }catch(e){
      rethrow;
    }
  }

  Future<ImageResponse> uploadImage(file) async {
    try{
          var response = await _apiService.uploadImage(AppUrl.uploadImage, file);
          return response = ImageResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<ProductModel> getProducts(page, limit) async {
    try{
      var url = '${AppUrl.products}&pagination%5Bpage%5D=$page&pagination%5BpageSize%5D=$limit';
      dynamic response = await _apiService
          .getApiResponse(url);
      return response = ProductModel.fromJson(response);
    }catch(error){
      rethrow;
    }
  }


}
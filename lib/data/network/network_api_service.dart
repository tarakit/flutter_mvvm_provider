import 'dart:convert';
import 'dart:io';

import 'package:flutter_mvvm_provider/data/app_exception.dart';
import 'package:flutter_mvvm_provider/res/app_url.dart';
import 'package:http/http.dart' as http;

class NetworkApiService {
  dynamic responseJson;

  Future<dynamic> getApiResponse(String url) async {
    try{
      var response = await http.get(Uri.parse(url));
      responseJson = returnResponse(response);
      // return response = ProductModel.fromJson(response);
    }on SocketException{
      throw FetchDataException('Wrong URL endpoint');
    }
    // print('response in network service $responseJson');
    return responseJson;
  }

  returnResponse(http.Response response) {
    // print('status returnResponse ${response.body}');
    switch(response.statusCode){
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException('bad request');
    }
  }
}
import 'dart:convert';
import 'dart:io';

import 'package:flutter_mvvm_provider/data/app_exception.dart';
import 'package:http/http.dart' as http;

class NetworkApiService {

  Future<dynamic> getApiResponse(String url) async {
    var responseJson;
    try{
      var response = await http.get(Uri.parse(url));
      responseJson = returnResponse(response);
    }on SocketException{
      throw FetchDataException('Wrong URL endpoint');
    }
    return responseJson;
  }

  returnResponse(http.Response response) {
    switch(response.statusCode){
      case 200: 
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException('bad request');
    }
  }
}
import 'dart:convert';
import 'dart:io';

import 'package:flutter_mvvm_provider/data/app_exception.dart';
import 'package:flutter_mvvm_provider/models/image_response.dart';
import 'package:http/http.dart' as http;

class NetworkApiService {
  dynamic responseJson;

  Future putApi(url, object) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('PUT', Uri.parse(url));
    request.body = json.encode(object);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      return json.decode(res);
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future postApi(url, object) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(object);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      return json.decode(res);
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future uploadImage(url, file) async{

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('files', file));
    // print('image data 222 $url');
    var response = await request.send();
    // print('image data response $response');
    var res = await response.stream.bytesToString();
    final decoded = json.decode(res);
    var imageList = List<ImageResponse>.from(
        decoded.map((image) => ImageResponse.fromJson(image)));
    // print('image data ${imageList[0].toJson()}');
    return imageList[0].toJson();
  }

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
        // print(jsonDecode(response.body));
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException('bad request');
    }
  }
}
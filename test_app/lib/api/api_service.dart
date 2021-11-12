import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {

  static final String? url = "http://hr.ekrut.co";
  static final String? urlGetRoles = "/items/role";
  static final String? urlGetUsers = "/items/users";

  // TODO : METHOD POST
  static createRole(dynamic bodyObject) async {
    try{
      final http.Response response =  await http.post(
        Uri.parse("$url$urlGetRoles"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: bodyObject
      );

      return checkResponse(response);
    } catch (exception) {
      print(exception);
      return checkException(exception);
    }

  }

  // TODO : METHOD GET
  static getUsers({String? page, String? perPage}) async {
    try{
      final http.Response response =  await http.get(
          Uri.parse("$url$urlGetUsers?page=$page&per_page=$perPage"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8'
          },
      );

      return checkResponse(response);
    } catch (exception) {
      print(exception);
      return checkException(exception);
    }

  }

  static getRoles({String? page, String? perPage}) async {
    try{
      final http.Response response =  await http.get(
          Uri.parse("$url$urlGetRoles?page=$page&per_page=$perPage"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8'
          },
      );

      return checkResponse(response);
    } catch (exception) {
      print(exception);
      return checkException(exception);
    }

  }

  static checkResponse(http.Response response){
    if(response.statusCode == 200){
      String body = utf8.decode(response.bodyBytes);
      final responseJson = jsonDecode(body);
      //print(response.body.runtimeType);
      return responseJson;
    }else{
      return json.decode(response.body);
    }
  }

  static checkException(dynamic exception){
    if(exception.toString().contains('SocketException')) {
      return 'NetworkError';
    } else {
      return null;
    }
  }

}
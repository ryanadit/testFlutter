import 'package:test_app/model/items/items_users_model.dart';

class DataUsersModel {

  List<UsersModel>? data;

  DataUsersModel({this.data});

  factory DataUsersModel.fromJson(Map? json) => DataUsersModel(
    data: List<UsersModel>.from(json?["data"].map((e) {
      return UsersModel.fromJson(e);
    }))
  );

}
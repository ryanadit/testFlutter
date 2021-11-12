import 'package:test_app/model/items/items_role_model.dart';

class DataSaveRolesModel {

  RoleModel? data;

  DataSaveRolesModel({this.data});

  factory DataSaveRolesModel.fromJson(Map? json) => DataSaveRolesModel(
    data: RoleModel?.fromJson(json?["data"])
  );

}
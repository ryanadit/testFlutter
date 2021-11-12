import 'package:test_app/model/items/items_role_model.dart';

class DataRolesModel {

  List<RoleModel>? data;

  DataRolesModel({this.data});

  factory DataRolesModel.fromJson(Map? json) => DataRolesModel(
      data: List<RoleModel>.from(json?["data"].map((e) {
        return RoleModel.fromJson(e);
      })),
  );

}
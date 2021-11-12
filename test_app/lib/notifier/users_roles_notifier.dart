import 'package:flutter/material.dart';
import 'package:test_app/api/api_service.dart';
import 'package:test_app/helper/helper.dart';
import 'package:test_app/model/data_roles_model.dart';
import 'package:test_app/model/data_users_model.dart';
import 'package:test_app/model/response_save_role_model.dart';


class UsersNotifier with ChangeNotifier {

  // TODO : GET USERS

  DataUsersModel? _usersModel;

  setDataUsers(Map? value) {
    _usersModel = null;
    _usersModel = DataUsersModel.fromJson(value);
    notifyListeners();
  }

  DataUsersModel? getDataUsers() => _usersModel;

  Future getUsers({ String? page, String? perPage }) async {
    final response = await ApiService.getUsers(page: page, perPage: perPage);
    if(response != Helper.networkError && response != null) {
      if(response is Map) {
        setDataUsers(response);
        return response;
      }
      return ;
    }
    return ;
  }

  // TODO : GET ROLES

  DataRolesModel? _roleModel;

  setDataRoles(Map? value) {
    _roleModel = null;
    _roleModel = DataRolesModel.fromJson(value);
    notifyListeners();
  }

  DataRolesModel? getDataRoles() => _roleModel;

  Future getRoles({ String? page, String? perPage }) async {
    final response = await ApiService.getRoles(page: page, perPage: perPage);
    if(response != Helper.networkError && response != null) {
      if(response is Map) {
        setDataRoles(response);
        return response;
      }
      return ;
    }
    return ;
  }

  // TODO : SAVE ROLE
  DataSaveRolesModel? _roleModelCreate;

  setDataRolesCreate(Map? value) {
    _roleModelCreate = null;
    _roleModelCreate = DataSaveRolesModel.fromJson(value);
    notifyListeners();
  }

  DataSaveRolesModel? getDataRolesCreate() => _roleModelCreate;

  Future postRolesCreate(dynamic bodyObject) async {

    final response = await ApiService.createRole(bodyObject);
    if(response != Helper.networkError && response != null) {
      if(response is Map) {
        setDataRolesCreate(response);
        return response;
      }
      return ;
    }
    return ;
  }



}
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:test_app/helper/helper_widget.dart';
import 'package:test_app/model/items/items_role_model.dart';
import 'package:test_app/notifier/users_roles_notifier.dart';


class SaveRoleNotifier with ChangeNotifier {

  Future<void> saveDataRole({ required BuildContext context, String? title, String? description, String? requirement, ProgressDialog? pd}) async {
    UsersNotifier? _usersNotifier = Provider.of(context, listen: false);
    try{
      pd = WidgetHelper.progressDialogShow(context, pd);
      final object = RoleModel(
          title: title,
          requirement: requirement,
          description: description
      ).toJson();
      final bodyObject = jsonEncode(object);
      final response = await _usersNotifier?.postRolesCreate(bodyObject);
      Future.delayed(Duration(milliseconds: 400)).then((value) {
        if(response != null) {
          pd!.close();
          WidgetHelper.alertDialog(context, "Success", "Sukses tambah role", WidgetHelper.modeAlertBackHome);
        } else {
          pd!.close();
          WidgetHelper.alertDialog(context, "Gagal", "Ada kesalahan, mohon coba lagi", WidgetHelper.modeAlertBack);
        }
      });

    }catch (e) {
      print(e);
    }

  }

  String? validator(dynamic val, String? title) {
    if(val!.isEmpty) {
      return "$title is Empty";
    }
    return null;
  }

}
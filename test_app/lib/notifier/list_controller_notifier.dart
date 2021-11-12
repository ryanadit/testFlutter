import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:test_app/model/items/items_role_model.dart';
import 'package:test_app/model/items/items_users_model.dart';
import 'package:test_app/notifier/users_roles_notifier.dart';

class ListControllerNotifier with ChangeNotifier {

  // TODO LOGIC FOR ROLES
  PagingController<int, RoleModel>? _pagingControllerRole = PagingController(firstPageKey: 1);
  UsersNotifier? _usersNotifier;
  int? _perPage = 100;

  Future fetchDataRoles(context, int pageKey) async {
    _usersNotifier = Provider.of(context, listen: false);

    try{
      // TODO INITIAL PAGE
      final page = (pageKey / _perPage!).floor()+1;

      await _usersNotifier?.getRoles(
          page: page.toString(),
          perPage: _perPage.toString()
      );
      var newItems = _usersNotifier?.getDataRoles()!.data;
      final isLastPage = newItems!.length < _perPage!;
      if(isLastPage){
        _pagingControllerRole?.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingControllerRole?.appendPage(newItems, nextPageKey);
      }

    } catch(error) {
      print(error);
      _pagingControllerRole?.error = error;
    }
    notifyListeners();

  }

  setControllerRole(PagingController<int, RoleModel>? pagingController) {
    _pagingControllerRole = PagingController(firstPageKey: 1);
    _pagingControllerRole = pagingController;
    notifyListeners();
  }

  Future<void> refreshDataRoles() async {
    Future.sync(
          () => _pagingControllerRole?.refresh(),
    );
    notifyListeners();
  }


  // TODO LOGIC FOR USERS
  PagingController<int, UsersModel>? _pagingControllerUsers = PagingController(firstPageKey: 1);

  Future fetchDataUsers(context, int pageKey) async {
    _usersNotifier = Provider.of(context, listen: false);

    try{
      // TODO INITIAL PAGE
      final page = (pageKey / _perPage!).floor()+1;

      await _usersNotifier?.getUsers(
          page: page.toString(),
          perPage: _perPage.toString()
      );
      var newItems = _usersNotifier?.getDataUsers()!.data;

      final isLastPage = newItems!.length < _perPage!;
      if(isLastPage){
        _pagingControllerUsers?.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingControllerUsers?.appendPage(newItems, nextPageKey);
      }


    } catch(error) {
      print(error);
      _pagingControllerUsers?.error = error;
    }
    notifyListeners();

  }

  setControllerUsers(PagingController<int, UsersModel>? pagingController) {
    _pagingControllerUsers = PagingController(firstPageKey: 1);
    _pagingControllerUsers = pagingController;
    notifyListeners();
  }

  Future<void> refreshDataUsers() async {
    Future.sync(
          () => _pagingControllerUsers?.refresh(),
    );
    notifyListeners();
  }

  // TODO TAP BOTTOM NAVBAR

  int _selectedIndex = 0;

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  int selectIndex() => _selectedIndex;

}
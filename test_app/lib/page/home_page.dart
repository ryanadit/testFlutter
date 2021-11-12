import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/notifier/list_controller_notifier.dart';
import 'package:test_app/page/role_page/list_role_page.dart';
import 'package:test_app/page/user_page/list_user_page.dart';


class HomePage extends StatelessWidget {

  static const String route_name = "/home_page";

  @override
  Widget build(BuildContext context) {

    List<Widget> _widgetOptions = [
      ListRolePage(),
      ListUserPage()
    ];

    return Consumer<ListControllerNotifier>(
      builder: (ctx, cont, widget) {
        return Scaffold(
          body: _widgetOptions.elementAt(cont.selectIndex()),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: _buildIcon(ctx, Icons.group, 30),
                  label: "Roles"
              ),
              BottomNavigationBarItem(
                  icon: _buildIcon(ctx, Icons.account_circle_rounded, 30),
                  label: "Users"
              ),
            ],
            currentIndex: cont.selectIndex(),
            selectedItemColor: Colors.cyan.shade700,
            onTap: cont.onItemTapped,
            type: BottomNavigationBarType.fixed,
          ),
        );
      },
    );
  }


  Widget _buildIcon(BuildContext context, IconData _icon, double _size){
    return Icon(
      _icon,
      size: MediaQuery.of(context).size.height/_size,
    );
  }






}

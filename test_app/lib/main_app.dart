import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/notifier/list_controller_notifier.dart';
import 'package:test_app/notifier/save_role_notifier.dart';
import 'package:test_app/notifier/users_roles_notifier.dart';
import 'package:test_app/page/home_page.dart';
import 'package:test_app/page/user_page/create_user_page.dart';

class MainApp extends StatelessWidget {

  final String? initialRoute;

  MainApp({
    Key? key,
    @required this.initialRoute
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsersNotifier()),
        ChangeNotifierProvider(create: (_) => ListControllerNotifier()),
        ChangeNotifierProvider(create: (_) => SaveRoleNotifier()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          HomePage.route_name: (_) => HomePage(),
          CreateRolePage.route_name: (_) => CreateRolePage(),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/main_app.dart';
import 'package:test_app/page/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? initialRoute = HomePage.route_name;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // transparent status bar
  ));
  runApp(MainApp(
    initialRoute: initialRoute,
  ));
}

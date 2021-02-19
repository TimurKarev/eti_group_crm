import 'package:eti_group_crm/services/auth.dart';
import 'package:eti_group_crm/ui/landing_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.grey[500],
        accentColor: Colors.red[400],

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: Colors.grey[400])
        ),

        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          headline3: TextStyle(
            fontSize: 24.0,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}

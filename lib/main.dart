import 'package:eti_group_crm/ui/auth/sing_in_page.dart';
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // colorScheme: ColorScheme(
        //   brightness: Brightness.light,
        //   primary: Colors.grey[300],
        //   primaryVariant: Colors.grey[400],
        //   secondary: Colors.red[400],
        //   secondaryVariant: Colors.red[500],
        //   surface: Colors.grey[200],
        //   background: Colors.blue[700],
        // ),
        primaryColor: Colors.grey[400],
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

      home: SingInPage(),
    );
  }
}

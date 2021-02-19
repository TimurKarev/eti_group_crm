import 'package:eti_group_crm/services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  HomePage({Key key, @required this.auth });

  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        actions: <Widget>[
          FlatButton(
            onPressed: _signOut,
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}

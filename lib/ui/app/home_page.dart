import 'package:eti_group_crm/services/auth_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = AuthProvider.of(context);
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
            onPressed: () => _signOut(context),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}

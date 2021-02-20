import 'package:eti_group_crm/services/auth.dart';
import 'package:flutter/material.dart';

import 'email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
  final AuthBase auth;

  const EmailSignInPage({Key key, @required this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вход в программу'),
        elevation: 4.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 3.0,
          child: EmailSignInForm(auth: auth),
        ),
      ),
    );
  }
}

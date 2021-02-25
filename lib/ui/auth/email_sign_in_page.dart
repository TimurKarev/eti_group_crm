import 'package:eti_group_crm/services/auth.dart';
import 'package:flutter/material.dart';

import 'email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вход в программу'),
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 3.0,
            child: EmailSignInForm(),
          ),
        ),
      ),
    );
  }
}

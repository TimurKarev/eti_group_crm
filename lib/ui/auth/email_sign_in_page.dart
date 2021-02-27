import 'package:eti_group_crm/ui/auth/email_sing_in_bloc_based.dart';
import 'package:flutter/material.dart';

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
            child: EmailSignInFormBlocBased.create(context),
          ),
        ),
      ),
    );
  }
}

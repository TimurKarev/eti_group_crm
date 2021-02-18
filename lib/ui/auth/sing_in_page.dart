import 'package:eti_group_crm/ui/config/custom_icon_icons.dart';
import 'package:eti_group_crm/ui/widgets/custom_raised_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SingInPage extends StatelessWidget {
  Future<void> _signInAnonymously() async {
    final userCred = await FirebaseAuth.instance.signInAnonymously();
    print('${userCred.user.uid}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ЭТИ Групп'),
          elevation: 2.0,
        ),
        body: _buildBodyContent(context));
  }

  Widget _buildBodyContent(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Вход на сайт',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 32.0),
            CustomRaisedButton(
              text: 'Войти по почте',
              icon: Icons.mail,
              onPressed: () {}, // TODO: add callback
            ),
            SizedBox(height: 18.0),
            CustomRaisedButton(
              text: 'Войти через Google',
              icon: CustomIcon.google,
              onPressed: () {}, // TODO: add callback
            ),
            SizedBox(height: 18.0),
            CustomRaisedButton(
              text: 'Войти через Apple',
              icon: CustomIcon.apple,
              onPressed: () {}, // TODO: add callback
            ),
            SizedBox(height: 40.0),
            CustomRaisedButton(
              text: 'Войти анонимно',
              icon: CustomIcon.ghost,
              onPressed: _signInAnonymously, // TODO: add callback
            ),
          ],
        ));
  }
}

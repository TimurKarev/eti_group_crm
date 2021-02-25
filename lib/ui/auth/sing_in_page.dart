import 'package:eti_group_crm/services/auth_provider.dart';
import 'package:eti_group_crm/ui/auth/email_sign_in_page.dart';
import 'package:eti_group_crm/ui/config/custom_icon_icons.dart';
import 'package:eti_group_crm/ui/widgets/custom_raised_button.dart';
import 'package:flutter/material.dart';

class SingInPage extends StatelessWidget {
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      final auth = AuthProvider.of(context);
      final user = await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  void _sighInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
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
              onPressed: () => _sighInWithEmail(context), // TODO: add callback
            ),
            SizedBox(height: 18.0),
            // CustomRaisedButton(
            //   text: 'Войти через Google',
            //   icon: CustomIcon.google,
            //   onPressed: _signInWithGoogle, // TODO: add callback
            // ),
            // SizedBox(height: 18.0),
            // CustomRaisedButton(
            //   text: 'Войти через Apple',
            //   icon: CustomIcon.apple,
            //   onPressed: () {}, // TODO: add callback
            // ),
            // SizedBox(height: 40.0),
            CustomRaisedButton(
              text: 'Войти анонимно',
              icon: CustomIcon.ghost,
              onPressed: () =>
                  _signInAnonymously(context), // TODO: add callback
            ),
          ],
        ));
  }
}

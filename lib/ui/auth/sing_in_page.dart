import 'package:eti_group_crm/blocs/sign_in_bloc.dart';
import 'package:eti_group_crm/services/auth.dart';
import 'package:eti_group_crm/ui/auth/email_sign_in_page.dart';
import 'package:eti_group_crm/ui/config/custom_icon_icons.dart';
import 'package:eti_group_crm/ui/widgets/custom_raised_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingInPage extends StatelessWidget {
  const SingInPage({Key key, @required this.bloc});

  final SignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(auth: auth),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
          builder: (_, bloc, __) => SingInPage(
                bloc: bloc,
              )),
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await bloc.signInAnonymously();
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
        body: StreamBuilder<bool>(
            stream: bloc.isLoadingStream,
            initialData: false,
            builder: (context, snapshot) {
              return _buildBodyContent(context, snapshot.data);
            }));
  }

  Widget _buildBodyContent(BuildContext context, bool isLoading) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildHeader(context, isLoading),
            SizedBox(height: 32.0),
            CustomRaisedButton(
              text: 'Войти по почте',
              icon: Icons.mail,
              onPressed: isLoading
                  ? null
                  : () => _sighInWithEmail(context), // TODO: add callback
            ),
            SizedBox(height: 18.0),
            CustomRaisedButton(
              text: 'Войти анонимно',
              icon: CustomIcon.ghost,
              onPressed: isLoading
                  ? null
                  : () => _signInAnonymously(context), // TODO: add callback
            ),
          ],
        ));
  }

  Widget _buildHeader(BuildContext context, bool isLoading) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Text(
        'Вход на сайт',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline3,
      );
    }
  }
}

import 'package:eti_group_crm/blocs/email_sign_in_bloc.dart';
import 'package:eti_group_crm/models/email_sign_in_model.dart';
import 'package:eti_group_crm/services/auth.dart';
import 'package:eti_group_crm/ui/widgets/custom_raised_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EmailSignInFormBlocBased extends StatefulWidget {
  final EmailSignInBloc bloc;

  EmailSignInFormBlocBased({Key key, this.bloc}) : super(key: key);

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => EmailSignInFormBlocBased(bloc: bloc),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormBlocBasedState createState() =>
      _EmailSignInFormBlocBasedState();
}

class _EmailSignInFormBlocBasedState extends State<EmailSignInFormBlocBased> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _submit() async {
    try {
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Ошибка входа'),
              content: Text(e.message),
              actions: [
                TextButton(
                  child: Text('Ok'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              ],
            );
          });
    }
  }

  void _toggleFormType() {
    widget.bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    return [
      _buildEmailTextField(model),
      _buildPasswordTextField(model),
      SizedBox(height: 18.0),
      CustomRaisedButton(
        height: 43.0,
        text: model.primaryButtonText,
        icon: model.primaryIcon,
        onPressed: model.canSubmit ? _submit : null,
      ),
      SizedBox(height: 18.0),
      TextButton(
        child: Text(model.secondaryText),
        onPressed: !model.isLoading ? _toggleFormType : null,
      ),
    ];
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      autocorrect: false,
      focusNode: _passwordFocusNode,
      textInputAction: TextInputAction.done,
      onChanged: widget.bloc.updatePassword,
      decoration: InputDecoration(
        errorText: model.passwordErrorText,
        labelText: 'Пароль',
        enabled: model.isLoading == false,
      ),
    );
  }

  TextField _buildEmailTextField(EmailSignInModel model) {
    return TextField(
      controller: _emailController,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _emailEditingComplete(model),
      focusNode: _emailFocusNode,
      onChanged: widget.bloc.updateEmail,
      decoration: InputDecoration(
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
        labelText: 'Почта',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(model),
            ),
          );
        });
  }
}

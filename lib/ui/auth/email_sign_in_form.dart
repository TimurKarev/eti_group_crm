import 'package:eti_group_crm/services/auth.dart';
import 'package:eti_group_crm/services/validators.dart';
import 'package:eti_group_crm/ui/widgets/custom_raised_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  final AuthBase auth;

  EmailSignInForm({Key key, @required this.auth}) : super(key: key);

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;

  String get _password => _passwordController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _submit() async {
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText =
        _formType == EmailSignInFormType.signIn ? 'Вход' : 'Регистрация';
    final primaryIcon = _formType == EmailSignInFormType.signIn
        ? Icons.login
        : Icons.app_registration;
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Нет аккаунта? Зарегестрироваться'
        : "Есть аккаунт? Войти в приложение";

    bool submitEnable = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password);

    return [
      _buildEmailWidget(),
      _buildPasswordField(),
      SizedBox(height: 18.0),

      CustomRaisedButton(
        height: 43.0,
        text: primaryText,
        icon: primaryIcon,
        onPressed: submitEnable ? _submit : null,
      ),
      SizedBox(height: 18.0),
      FlatButton(
        child: Text(secondaryText),
        onPressed: _toggleFormType,
      ),
    ];
  }

  TextField _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      autocorrect: false,
      focusNode: _passwordFocusNode,
      textInputAction: TextInputAction.done,
      onChanged: (_password) => _updateState(),
      decoration: InputDecoration(
        labelText: 'Пароль',
      ),
    );
  }

  TextField _buildEmailWidget() {
    return TextField(
      controller: _emailController,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
      focusNode: _emailFocusNode,
      onChanged: (_email) => _updateState(),
      decoration: InputDecoration(
        labelText: 'Почта',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  _updateState() {
    setState(() {});
  }
}

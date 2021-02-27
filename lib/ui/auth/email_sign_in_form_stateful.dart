import 'dart:io';

import 'package:eti_group_crm/models/email_sign_in_model.dart';
import 'package:eti_group_crm/services/auth.dart';
import 'package:eti_group_crm/services/validators.dart';
import 'package:eti_group_crm/ui/widgets/custom_raised_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EmailSignInFormStateful extends StatefulWidget with EmailAndPasswordValidators {
  @override
  _EmailSignInFormStatefulState createState() => _EmailSignInFormStatefulState();
}

class _EmailSignInFormStatefulState extends State<EmailSignInFormStateful> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;

  String get _password => _passwordController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  bool _submitted = false;
  bool _isLoading = false;

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
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
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    return [
      _buildEmailTextField(),
      _buildPasswordTextField(),
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
        onPressed: !_isLoading ? _toggleFormType : null,
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      obscureText: true,
      autocorrect: false,
      focusNode: _passwordFocusNode,
      textInputAction: TextInputAction.done,
      onChanged: (_password) => _updateState(),
      decoration: InputDecoration(
        errorText: showErrorText ? widget.invalidPasswordText : null,
        labelText: 'Пароль',
        enabled: _isLoading == false,
      ),
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
      focusNode: _emailFocusNode,
      onChanged: (_email) => _updateState(),
      decoration: InputDecoration(
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        enabled: _isLoading == false,
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

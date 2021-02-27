import 'package:eti_group_crm/services/validators.dart';
import 'package:flutter/material.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidators {
  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;

  EmailSignInModel(
      {this.email = '',
      this.password = '',
      this.formType = EmailSignInFormType.signIn,
      this.isLoading = false,
      this.submitted = false});

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn ? 'Вход' : 'Регистрация';
  }

  IconData get primaryIcon {
    return formType == EmailSignInFormType.signIn
        ? Icons.login
        : Icons.app_registration;
  }

  String get secondaryText {
    return formType == EmailSignInFormType.signIn
        ? 'Нет аккаунта? Зарегестрироваться'
        : "Есть аккаунт? Войти в приложение";
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);

    return showErrorText ? invalidPasswordText : null;
  }

  String get emailErrorText {
    bool showErrorText =
        submitted && !emailValidator.isValid(email);

    return showErrorText ? invalidEmailErrorText : null;
  }

  EmailSignInModel copyWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}

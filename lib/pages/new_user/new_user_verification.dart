import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

/// Gera um diálogo de alerta caso o cadastro esteja errado.
createAlertDialog(BuildContext context, String message) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Erro!'),
          content: Text(message),
          backgroundColor: const Color(0xff731FA1),
          actions: <Widget>[
            MaterialButton(
                elevation: 5.0,
                child: const Text('Ok'),
                color: const Color(0xff291C30),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      });
}

/// Verifica:
/// - Validade do email
/// - Força da senha
/// - Correspondência entre senhas
bool verify(String email, String password, String confirmPassword,
    BuildContext context) {
  if (!EmailValidator.validate(email)) {
    createAlertDialog(context, 'Insira um e-mail válido!');
    return false;
  } else if (password != confirmPassword) {
    createAlertDialog(context, 'As senhas não são correspondentes!');
    return false;
  } else if (password.length < 6) {
    createAlertDialog(context, 'A senha deve ter ao menos 6 dígitos!');
    return false;
  }
  return true;
}

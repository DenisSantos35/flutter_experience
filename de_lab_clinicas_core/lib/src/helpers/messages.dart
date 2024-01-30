import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

//classe para criação de snacks bar padrão, toda vez que necessitar em uma parte do sistema e so chamar e passar a message
final class Messages {
  static void showError(String message, BuildContext context) {
    Overlay.of(context);
    CustomSnackBar.error(message: message);
  }

  static void showInfo(String message, BuildContext context) {
    Overlay.of(context);
    CustomSnackBar.info(message: message);
  }

  static void showSucess(String message, BuildContext context) {
    Overlay.of(context);
    CustomSnackBar.success(message: message);
  }
}

//mixin extende varias classes com metodo with
//controle das mensagens - fica na controller
mixin MessageStateMixin {
  //este erro nao pode ser alterado de qualquer lugar ma pode ser recuperado
  final Signal<String?> _errorMessage = signal(null);
  String? get errorMessage => _errorMessage();

  final Signal<String?> _infoMessage = signal(null);
  String? get infoMessage => _infoMessage();

  final Signal<String?> _sucessMessage = signal(null);
  String? get sucessMessage => _sucessMessage();

  void clearError() => _errorMessage.value = null;
  void clearInfo() => _infoMessage.value = null;
  void clearSucess() => _sucessMessage.value = null;

  void showError(String message) {
    untracked(() => clearError());
    _errorMessage.value = message;
  }

  void showInfo(String message) {
    untracked(() => clearInfo());
    _infoMessage.value = message;
  }

  void showSucess(String message) {
    untracked(() => clearSucess());
    _sucessMessage.value = message;
  }

  void clearAllMessage() {
    untracked(() {
      clearError();
      clearInfo();
      clearSucess();
    });
  }
}

//notifica mudanca de estado - fica na view
mixin MessageViewMixn<T extends StatefulWidget> on State<T> {
  //fica ouvindo a classe de messages caso haja mudanca de estado notifica
  void messageListener(MessageStateMixin state) {
    effect(() {
      switch (state) {
        case MessageStateMixin(:final errorMessage?):
          Messages.showError(errorMessage, context);
        case MessageStateMixin(:final infoMessage?):
          Messages.showInfo(infoMessage, context);
        case MessageStateMixin(:final sucessMessage?):
          Messages.showSucess(sucessMessage, context);
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:prueba/core/widgets/dialog.dart';

class BaseViewModel {

  void showMessage(BuildContext context, String msg) {
    showSnackBar(context, msg, 300);
  }

}
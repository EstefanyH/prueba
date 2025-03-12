import 'package:flutter/material.dart';
import 'package:prueba/core/widgets/dialog.dart';

class BaseViewModel {

  ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  ValueNotifier<bool> get isLoading => _isLoading;

  void showLoading() async {
    _isLoading.value = true; // Activa el estado de carga
    await Future.delayed(const Duration(seconds: 5)); // Simula un tiempo de carga
  
  }

  void hideLoading() async {
    _isLoading.value = false; // Desactiva el estado de carga
  }

  void showMessage(BuildContext context, String msg) {
    showSnackBar(context, msg, 600);
  }

}
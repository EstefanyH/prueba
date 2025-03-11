import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, int duration) {
  final snackBar = SnackBar(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10), 
        topRight: Radius.circular(10))),
    backgroundColor: Colors.green[700], //Colors.indigo
    content: Text(message, 
    textAlign: TextAlign.center,), 
    duration:  Duration(milliseconds: duration),);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

}
import 'package:flutter/material.dart';

abstract class SnackBarHandler {
  void showSnackBar(String message);
}

class SnackBarHandlerImp implements SnackBarHandler {
  SnackBarHandlerImp(this.context);

  final BuildContext context;

  @override
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

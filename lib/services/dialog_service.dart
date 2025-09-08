import 'package:flutter/material.dart';

class DialogService {
  static final DialogService _instance = DialogService._internal();
  factory DialogService() => _instance;

  DialogService._internal();

  Widget? _currentDialog;

  Future<void> showDialog({
    required BuildContext context,
    required Widget widget,
  }) async {
    if (_currentDialog != null) {
      // A dialog is already being shown
      return;
    }
    _currentDialog = widget;
    await showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return _currentDialog!;
      },
    ).then((value) {
      _currentDialog = null;
    });
  }

  Future<void> hideDialog(BuildContext context) async {
    if (_currentDialog != null) {
      Navigator.of(context, rootNavigator: true).pop();
      _currentDialog = null;
    }
  }
}

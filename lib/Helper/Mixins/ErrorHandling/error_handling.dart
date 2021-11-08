import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// This is my great mixin for ErrorHandling... this should help to avoid code
/// duplications for the Widgets which should show any error messages... but I guess
/// there should be more appropriate way to handle this
mixin ErrorHandlingMixin {
  void handleError(String? error, BuildContext context) {
    if (error == null) return;

    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      _showSnackBar(context, error);
    });
  }

  void _showSnackBar(BuildContext context, String error) {
    final snack = SnackBar(content: Text(error));

    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}

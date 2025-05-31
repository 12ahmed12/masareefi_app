import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../models/api_error_model.dart';
import '../widgets/alert_dialog_widget.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

void showsSuccessDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialogWidget(
        text: text,
        iconPath: 'assets/icons/right.svg',
      );
    },
  );
}

void showsFailDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialogWidget(
        text: text,
        iconPath: 'assets/icons/wrong.svg',
      );
    },
  );
}

void setupErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
  logger.i('Setup-Error: $apiErrorModel');

  String errorMessage;

  // ✅ If the API returns an errors list, show the first error
  if (apiErrorModel.errors != null && apiErrorModel.errors!.isNotEmpty) {
    errorMessage = apiErrorModel.errors!.map((e) => e.message).join("\n");
  }
  // ✅ Otherwise, fallback to the main message
  else {
    errorMessage = apiErrorModel.message ?? "An unknown error occurred";
  }

  showDialog(
    context: context,
    builder: (context) => AlertDialogWidget(
      iconPath: 'assets/icons/wrong.svg',
      text: errorMessage,
    ),
  );
}

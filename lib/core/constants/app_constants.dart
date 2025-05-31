import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import '../../main.dart';
import '../helpers/shared_pref_helper.dart';

Future<void> removeUserToken() async {
  await SharedPrefHelper.clearAllSecuredData();
}

/*Future<void> changeLang(context, Language language) async {
  setLocale(language.languageCode).then((value) {
    lang = value.languageCode;
    MyApp.setLocale(context, value);
  });
}*/

var logger = Logger(
  printer: PrettyPrinter(),
);

import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

import '../theming/colors.dart';

class MyUpgrader extends Upgrader {
  MyUpgrader({super.debugLogging});

  @override
  bool isUpdateAvailable() {
    final storeVersion = currentAppStoreVersion;
    final installedVersion = currentInstalledVersion;
    print('storeVersion=$storeVersion');
    print('installedVersion=$installedVersion');
    return super.isUpdateAvailable();
  }
}

class MyUpgradeAlert extends UpgradeAlert {
  MyUpgradeAlert({super.key, super.upgrader, super.child});

  /// Override the [createState] method to provide a custom class
  /// with overridden methods.
  @override
  UpgradeAlertState createState() => MyUpgradeAlertState();
}

class MyUpgradeAlertState extends UpgradeAlertState {
  @override
  Widget alertDialog(
      Key? key,
      String title,
      String message,
      String? releaseNotes,
      BuildContext context,
      bool cupertino,
      UpgraderMessages messages) {
    return Theme(
      data: ThemeData(
        dialogTheme: const DialogTheme(
          titleTextStyle: TextStyle(color: AppColors.mainColor, fontSize: 48),
          contentTextStyle: TextStyle(color: Colors.green, fontSize: 18),
        ),
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            // Change the color of the text buttons.
            foregroundColor: WidgetStatePropertyAll(Colors.orange),
          ),
        ),
      ),
      child: super.alertDialog(
          key, title, message, releaseNotes, context, cupertino, messages),
    );
  }
}

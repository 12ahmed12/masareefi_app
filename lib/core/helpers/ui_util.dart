import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_defaults.dart';
import '../enums/toast_status.dart';
import '../theming/colors.dart';

class UiUtil {
  /// OPENS BOTTOM SHEET WITH THE GIVEN WIDGET
  static Future openBottomSheet({
    required BuildContext context,
    required Widget widget,
  }) async {
    await showModalBottomSheet(
      context: context,
      builder: (ctx) => widget,
      isScrollControlled: true,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: AppDefaults.bottomSheetRadius,
      ),
    );
  }

  /// Opens dialog with background blur enabled
  static Future openDialog({
    required BuildContext context,
    required Widget widget,
    bool isDismissable = false,
  }) async {
    return await showGeneralDialog(
      barrierLabel: 'Dialog',
      barrierDismissible: isDismissable,
      context: context,
      pageBuilder: (ctx, anim1, anim2) => widget,
      transitionBuilder: (ctx, anim1, anim2, child) => ScaleTransition(
        scale: anim1,
        child: child,
      ),
    );
  }

  static void showErrorAlert({
    required String title,
    required String description,
    required BuildContext context,
  }) =>
      AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.topSlide,
              showCloseIcon: true,
              title: title,
              desc: description,
              descTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              btnOkOnPress: () {
                //Navigator.pop(context);
              })
          .show();

  static void showInfoAlert(
          {required String title,
          required String description,
          required BuildContext context,
          required Function onClick}) =>
      AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.topSlide,
          showCloseIcon: true,
          title: title,
          desc: description,
          descTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.all(10),
          btnOkText: 'go',
          btnOkColor: AppColors.mainColor,
          btnOkOnPress: () {
            onClick();
          }).show();

  static void showSuccessAlert({
    required String title,
    required String description,
    required BuildContext context,
  }) =>
      AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.topSlide,
              showCloseIcon: true,
              title: title,
              desc: description,
              descTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              btnOkOnPress: () {
                //Navigator.pop(context);
              })
          .show();

  static void showCustomSuccessAlert({
    required String title,
    required String description,
    required BuildContext context,
    required Function function,
    required bool showIcon,
    required String btnText,
  }) =>
      AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.topSlide,
          showCloseIcon: showIcon,
          title: title,
          padding: const EdgeInsets.all(5),
          alignment: Alignment.center,
          desc: description,
          btnOkText: btnText,
          descTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          btnOkOnPress: () {
            function();
          }).show();

  static showSnackBar(BuildContext context, String text,
      {int duration = 5, required bool isHome, bool isDetails = false}) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: Duration(seconds: duration),
        content: Text(text),
        backgroundColor: AppColors.mainColor,
        actionOverflowThreshold: 1,
        showCloseIcon: true,
        closeIconColor: AppColors.lighterGray,
        action: SnackBarAction(
            textColor: AppColors.lighterGray, label: 'go', onPressed: () {}),
      ));
  }

  static void showToast({
    required String text,
    required ToastStates state,
  }) =>
      Fluttertoast.showToast(
          msg: text,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: chooseToastColor(state),
          textColor: Colors.white,
          webShowClose: true,
          fontSize: 16.0);

  static Color? chooseToastColor(ToastStates state) {
    Color color;

    switch (state) {
      case ToastStates.SUCCESS:
        color = Colors.green;
        break;
      case ToastStates.ERROR:
        color = Colors.red;
        break;
      case ToastStates.WARNING:
        color = Colors.amber;
        break;
    }
    return color;
  }
}

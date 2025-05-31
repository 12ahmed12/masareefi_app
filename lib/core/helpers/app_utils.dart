import 'package:url_launcher/url_launcher.dart';

import '../constants/app_constants.dart';
import 'constants.dart';
import 'package:flutter/material.dart';

class MapCallUtils {
  MapCallUtils._();
  //static bool _isButtonTapped = false;

  static void dismissKeyboard({required BuildContext context}) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  static Future<bool> onBackButtonPress(BuildContext context) async {
    print('onBackButtonPress');
    // Handle back button press logic here
    final shouldExit = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Exit'),
        content: Text('Are you sure you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false), // Cancel
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true), // Exit
            child: Text('Exit'),
          ),
        ],
      ),
    );
    return shouldExit ?? false; // Default to false to prevent accidental exit
  }

  static Future<void> openMap(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    //await launchUrl(launchUri);
    if (!await launchUrl(
      launchUri,
    )) {
      logger.d('Could not launch $phoneNumber');
      throw Exception('Could not launch $phoneNumber');
    }
  }

  static Future<void> sendEmail(String email) async {
    String subject = Uri.encodeComponent("Hello Alcon");
    String body = Uri.encodeComponent("Hi! I'm a patient");

    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail)) {
      logger.d('done');
    } else {
      logger.d("ERRROOOOOOOR");
    }
  }

  static Future<void> sendViaWhatsapp(String whatsappLink) async {
    final Uri launchUriWhatsapp = Uri.parse(whatsappLink);
    //await launchUrl(launchUriWhatsapp);
    if (!await launchUrl(
      launchUriWhatsapp,
    )) {
      logger.d('Could not launch $whatsappLink');
      throw Exception('Could not launch $whatsappLink');
    }
  }
}

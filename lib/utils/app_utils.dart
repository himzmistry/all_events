import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_colors.dart';

class AppUtils {
  static double getHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static goBack(BuildContext context) => Navigator.of(context).pop(true);

  static showSnackBar(String? msg, BuildContext context, {Color? color}) {
    final snackBar = SnackBar(
      content: Text(msg ?? ''),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future<void> launchUri(url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      print('launchUrl: $e');
    }
  }
}

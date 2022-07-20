import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilsProvider extends ChangeNotifier {
  Future<void> OpenUriExternal(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}

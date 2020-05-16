import 'dart:convert';

import 'package:flutter/services.dart';

// https://medium.com/@sokrato/storing-your-secret-keys-in-flutter-c0b9af1c0f69
class Secret {
  static Future<Map<String, String>> getSecrets(String secretPath) async {
    return rootBundle.loadStructuredData<Map<String, String>>(secretPath,
    (jsonStr) async {
      return jsonDecode(jsonStr);
    });
  }

}
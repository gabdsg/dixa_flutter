// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'dixa_flutter_platform_interface.dart';

/// A web implementation of the DixaFlutterPlatform of the DixaFlutter plugin.
class DixaFlutterWeb extends DixaFlutterPlatform {
  /// Constructs a DixaFlutterWeb
  DixaFlutterWeb();

  static void registerWith(Registrar registrar) {
    DixaFlutterPlatform.instance = DixaFlutterWeb();
  }

  @override
  Future<void> configure({required String apiKey}) {
    this.apiKey = apiKey;
    return Future.value();
  }

  @override
  Future<void> setPushToken({required String token}) {
    return Future.value();
  }

  @override
  Future<bool> updateUserCredentials({
    required String username,
    required String email,
  }) async {
    js.context.callMethod('Dixa', [
      'init',
      js.JsObject.jsify(
        {
          "hideToggler": true,
          "messengerToken": apiKey,
          "userIdentity": {
            "type": "claim",
            // assuming that you have a userProfile object that contains user info
            "name": username,
            "email": email,
          },
        },
      ),
    ]);
    return Future.value(true);
  }

  @override
  Future<bool> clearUserCredentials() {
    js.context.callMethod('Dixa', [
      'purgeUserIdentity',
    ]);
    return Future.value(true);
  }

  @override
  Future<void> openMessenger() {
    js.context.callMethod(
      'Dixa',
      [
        'setWidgetOpen',
        true,
      ],
    );
    return Future.value();
  }
}

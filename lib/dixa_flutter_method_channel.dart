import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dixa_flutter_platform_interface.dart';

/// An implementation of [DixaFlutterPlatform] that uses method channels.
class MethodChannelDixaFlutter extends DixaFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dixa_flutter');

  @override
  Future<void> configure({required String apiKey}) async {
    await methodChannel.invokeMethod('configure', <String, dynamic>{
      'apiKey': apiKey,
    });
  }

  @override
  Future<void> setPushToken({required String token}) async {
    await methodChannel.invokeMethod('setPushToken', <String, dynamic>{
      'token': token,
    });
  }

  @override
  Future<bool> updateUserCredentials({
    required String username,
    required String email,
  }) async {
    return await methodChannel
        .invokeMethod('updateUserCredentials', <String, dynamic>{
      'username': username,
      'email': email,
    });
  }

  @override
  Future<bool> clearUserCredentials() async {
    return await methodChannel.invokeMethod('clearUserCredentials');
  }

  @override
  Future<void> openMessenger() async {
    await methodChannel.invokeMethod('openMessenger');
  }

  @override
  Future<void> processPushMessage(Object message) async {
    await methodChannel.invokeMethod('openMessenger', {
      "remoteMessage": message,
    });
  }
}

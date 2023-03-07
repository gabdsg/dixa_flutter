import 'dixa_flutter_platform_interface.dart';

class DixaFlutter {
  Future<void> configure({required String apiKey}) {
    return DixaFlutterPlatform.instance.configure(apiKey: apiKey);
  }

  Future<void> setPushToken({required String token}) {
    return DixaFlutterPlatform.instance.setPushToken(token: token);
  }

  Future<bool> updateUserCredentials({
    required String username,
    required String email,
  }) async {
    return DixaFlutterPlatform.instance
        .updateUserCredentials(username: username, email: email);
  }

  Future<bool> clearUserCredentials() {
    return DixaFlutterPlatform.instance.clearUserCredentials();
  }

  Future<void> openMessenger() {
    return DixaFlutterPlatform.instance.openMessenger();
  }

  Future<void> processPushMessage(Object message) async {
    return DixaFlutterPlatform.instance.processPushMessage(message);
  }
}

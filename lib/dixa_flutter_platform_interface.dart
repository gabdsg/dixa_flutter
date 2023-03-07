import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dixa_flutter_method_channel.dart';

abstract class DixaFlutterPlatform extends PlatformInterface {
  /// Constructs a DixaFlutterPlatform.
  DixaFlutterPlatform() : super(token: _token);

  String? apiKey;

  static final Object _token = Object();

  static DixaFlutterPlatform _instance = MethodChannelDixaFlutter();

  /// The default instance of [DixaFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelDixaFlutter].
  static DixaFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DixaFlutterPlatform] when
  /// they register themselves.
  static set instance(DixaFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> configure({required String apiKey}) {
    throw UnimplementedError('cofigure() has not been implemented.');
  }

  Future<void> setPushToken({required String token}) {
    throw UnimplementedError('cofigure() has not been implemented.');
  }

  Future<bool> updateUserCredentials({
    required String username,
    required String email,
  }) {
    throw UnimplementedError(
        'updateUserCredentials() has not been implemented.');
  }

  Future<bool> clearUserCredentials() {
    throw UnimplementedError(
        'clearUserCredentials() has not been implemented.');
  }

  Future<void> openMessenger() {
    throw UnimplementedError('openMessenger() has not been implemented.');
  }
}

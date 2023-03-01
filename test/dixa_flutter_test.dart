import 'package:flutter_test/flutter_test.dart';
import 'package:dixa_flutter/dixa_flutter_platform_interface.dart';
import 'package:dixa_flutter/dixa_flutter_method_channel.dart';

void main() {
  final DixaFlutterPlatform initialPlatform = DixaFlutterPlatform.instance;

  test('$MethodChannelDixaFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDixaFlutter>());
  });
}

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart' show required;

class UrlLauncherIos {
  static const MethodChannel _channel = const MethodChannel('url_launcher_ios');

  Future<bool> canLaunch(String url) {
    return _channel.invokeMethod<bool>(
      'canLaunch',
      <String, Object>{'url': url},
    );
  }

  Future<void> closeWebView() {
    return _channel.invokeMethod<void>('closeWebView');
  }

  Future<bool> launch(
    String url, {
    @required bool useSafariVC,
    @required bool useWebView,
    @required bool enableJavaScript,
    @required bool enableDomStorage,
    @required bool universalLinksOnly,
    @required Map<String, String> headers,
  }) {
    return _channel.invokeMethod<bool>(
      'launch',
      <String, Object>{
        'url': url,
        'useSafariVC': useSafariVC,
        'useWebView': useWebView,
        'enableJavaScript': enableJavaScript,
        'enableDomStorage': enableDomStorage,
        'universalLinksOnly': universalLinksOnly,
        'headers': headers,
      },
    );
  }
}

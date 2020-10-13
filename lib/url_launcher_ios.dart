import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart' show required;

class UrlLauncherIos {
  static const MethodChannel _channel = const MethodChannel('url_launcher_ios');

  Future<bool> canLaunch(String url) async {
    if (url == null) {
      return false;
    }
    return await _channel.invokeMethod<bool>(
      'canLaunch',
      <String, Object>{'url': url},
    );
  }

  Future<void> closeWebView() async {
    return await _channel.invokeMethod<void>('closeWebView');
  }

  Future<bool> launch(
    String urlString, {
    bool forceSafariVC,
    bool forceWebView,
    bool enableJavaScript,
    bool enableDomStorage,
    bool universalLinksOnly,
    Map<String, String> headers,
    Brightness statusBarBrightness,
    String webOnlyWindowName,
  }) async {
    assert(urlString != null);
    final Uri url = Uri.parse(urlString.trimLeft());
    final bool isWebURL = url.scheme == 'http' || url.scheme == 'https';
    if ((forceSafariVC == true || forceWebView == true) && !isWebURL) {
      throw PlatformException(
          code: 'NOT_A_WEB_SCHEME',
          message: 'To use webview or safariVC, you need to pass'
              'in a web URL. This $urlString is not a web URL.');
    }

    /// [true] so that ui is automatically computed if [statusBarBrightness] is set.
    bool previousAutomaticSystemUiAdjustment = true;
    if (statusBarBrightness != null) {
      previousAutomaticSystemUiAdjustment = WidgetsBinding.instance.renderView.automaticSystemUiAdjustment;
      WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
      SystemChrome.setSystemUIOverlayStyle(
          statusBarBrightness == Brightness.light ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light);
    }
    final bool result = await _channel.invokeMethod<bool>(
      'launch',
      <String, Object>{
        'url': urlString,
        'useSafariVC': forceSafariVC ?? true,
        'useWebView': forceWebView ?? false,
        'enableJavaScript': enableJavaScript ?? false,
        'enableDomStorage': enableDomStorage ?? false,
        'universalLinksOnly': universalLinksOnly ?? false,
        'headers': headers ?? <String, String>{},
      },
    );

    assert(previousAutomaticSystemUiAdjustment != null);
    if (statusBarBrightness != null) {
      WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = previousAutomaticSystemUiAdjustment;
    }

    return result;
  }
}

/// Copyright (c) 2019, Steve Rogers. All rights reserved. Use of this source code
/// is governed by an Apache License 2.0 that can be found in the LICENSE file.
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// A Simple plug-in that can be used to interogate a device( iOS or Android) to obtain a list of current set up locales and languages
class Devicelocale {
  /// Initializes the plugin and starts listening for potential platform events.
  factory Devicelocale() {
    if (_instance == null) {
      final MethodChannel methodChannel =
          const MethodChannel('uk.spiralarm.flutter/devicelocale');
      _instance = Devicelocale.private(methodChannel);
    }
    return _instance;
  }

  /// This constructor is only used for testing and shouldn't be accessed by
  /// users of the plugin. It may break or change at any time.
  @visibleForTesting
  Devicelocale.private(this._methodChannel);

  static Devicelocale _instance;

  final MethodChannel _methodChannel;

  /// Returns a [List] of locales from the device
  /// the first in the list should be the current one set on the device
  /// for example iOS **['en-GB', 'es-GB'] or for Android **['en_GB, 'es_GB]**
  Future<List<String>> get preferredLanguages async {
    return await _methodChannel.invokeListMethod<String>('preferredLanguages');
  }

  /// Returns a [String] of the currently set DEVICE locale made up of the language and the region
  /// (e.g. en-US or en_US)
  Future<String> get currentLocale async {
    return await _methodChannel.invokeMethod<String>('currentLocale');
  }

  /// Returns a ISO-4217 [String] of the currencyCode that is applicable to the current locale
  Future<String> get currentCurrency async {
    return await _methodChannel.invokeMethod<String>('currentCurrency');
  }
}

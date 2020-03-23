import 'dart:async';

import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/services.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

void main() {
  MockMethodChannel methodChannel;
  Devicelocale devicelocale;

  setUp(() {
    methodChannel = MockMethodChannel();
    devicelocale = Devicelocale.private(methodChannel);
  });

  test('preferredLanguages', () async {
    when(methodChannel.invokeListMethod<String>('preferredLanguages'))
        .thenAnswer((Invocation invoke) =>
            Future<List<String>>.value(['de_DE', 'en_US']));
    expect(await devicelocale.preferredLanguages, ['de_DE', 'en_US']);
  });

  test('currentLocale', () async {
    when(methodChannel.invokeMethod<String>('currentLocale'))
        .thenAnswer((Invocation invoke) => Future<String>.value('en_US'));
    expect(await devicelocale.currentLocale, 'en_US');
  });

  test('currentCurrency', () async {
    when(methodChannel.invokeMethod<String>('currentCurrency'))
        .thenAnswer((Invocation invoke) => Future<String>.value('EUR'));
    expect(await devicelocale.currentCurrency, 'EUR');
  });
}

class MockMethodChannel extends Mock implements MethodChannel {}

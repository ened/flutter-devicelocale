#import "DevicelocalePlugin.h"

@implementation DevicelocalePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"uk.spiralarm.flutter/devicelocale"
            binaryMessenger:[registrar messenger]];
  DevicelocalePlugin* instance = [[DevicelocalePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"preferredLanguages" isEqualToString:call.method]) {
    result([NSLocale preferredLanguages]);
  } else if([@"currentLocale" isEqualToString:call.method]) {
    NSString *locale = [self determineCurrentLocale];
    result(locale);
  } else if([@"currentCurrency" isEqualToString:call.method]) {
    NSString *currency = [self determineCurrentCurrency];
    result(currency);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (NSString*)determineCurrentLocale {
  NSString *language = [[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode];
  NSString *countryCode = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];

  if (countryCode == nil) {
    return [NSString stringWithFormat:@"%@", language];
  } else {
    return [NSString stringWithFormat:@"%@-%@", language, countryCode];
  };
}

- (NSString*)determineCurrentCurrency {
  if (@available(iOS 10.0, *)) {
    return [[NSLocale currentLocale] currencyCode];
  } else {
    // https://stackoverflow.com/a/5039433/375209
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:[NSLocale currentLocale]];
    
    return formatter.currencyCode;
  }
}

@end

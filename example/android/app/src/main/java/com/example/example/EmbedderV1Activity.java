package com.example.example;

import android.os.Bundle;
import com.example.devicelocale.DevicelocalePlugin;
import io.flutter.app.FlutterActivity;

public class EmbedderV1Activity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    DevicelocalePlugin.registerWith(registrarFor("com.example.devicelocale.DevicelocalePlugin"));
  }
}

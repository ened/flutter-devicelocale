package com.example.devicelocale;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * DevicelocalePlugin
 */
public class DevicelocalePlugin implements FlutterPlugin {

  private final MethodCallHandlerImpl impl;

  /**
   * Initialize this within the {@code #configureFlutterEngine} of a Flutter activity or fragment.
   */
  public DevicelocalePlugin() {
    impl = new MethodCallHandlerImpl();
  }

  /**
   * Registers a plugin implementation that uses the stable {@code io.flutter.plugin.common}
   * package.
   *
   * <p>Calling this automatically initializes the plugin.
   */
  public static void registerWith(Registrar registrar) {
    MethodCallHandlerImpl impl = new MethodCallHandlerImpl();
    impl.startListening(registrar.messenger());
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    impl.startListening(binding.getBinaryMessenger());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    impl.stopListening();
  }
}

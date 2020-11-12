package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    ShimPluginRegistry shimPluginRegistry = new ShimPluginRegistry(flutterEngine);
    flutterEngine.getPlugins().add(new io.flutter.plugins.deviceinfo.DeviceInfoPlugin());
    flutterEngine.getPlugins().add(new com.it_nomads.fluttersecurestorage.FlutterSecureStoragePlugin());
      com.flutter_webview_plugin.FlutterWebviewPlugin.registerWith(shimPluginRegistry.registrarFor("com.flutter_webview_plugin.FlutterWebviewPlugin"));
      com.onesignal.flutter.OneSignalPlugin.registerWith(shimPluginRegistry.registrarFor("com.onesignal.flutter.OneSignalPlugin"));
  }
}

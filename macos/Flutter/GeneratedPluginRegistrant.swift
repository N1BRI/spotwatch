//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import connectivity_plus
import geolocator_apple
import package_info_plus
import url_launcher_macos
import wakelock_macos

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  ConnectivityPlusPlugin.register(with: registry.registrar(forPlugin: "ConnectivityPlusPlugin"))
  GeolocatorPlugin.register(with: registry.registrar(forPlugin: "GeolocatorPlugin"))
  FPPPackageInfoPlusPlugin.register(with: registry.registrar(forPlugin: "FPPPackageInfoPlusPlugin"))
  UrlLauncherPlugin.register(with: registry.registrar(forPlugin: "UrlLauncherPlugin"))
  WakelockMacosPlugin.register(with: registry.registrar(forPlugin: "WakelockMacosPlugin"))
}

//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flutter_secure_storage/flutter_secure_storage_plugin.h>
#include <realm/realm_plugin.h>
#include <url_launcher_linux/url_launcher_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) flutter_secure_storage_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlutterSecureStoragePlugin");
  flutter_secure_storage_plugin_register_with_registrar(flutter_secure_storage_registrar);
  g_autoptr(FlPluginRegistrar) realm_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "RealmPlugin");
  realm_plugin_register_with_registrar(realm_registrar);
  g_autoptr(FlPluginRegistrar) url_launcher_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "UrlLauncherPlugin");
  url_launcher_plugin_register_with_registrar(url_launcher_linux_registrar);
}

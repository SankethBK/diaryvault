#include "include/simple_accordion/simple_accordion_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "simple_accordion_plugin.h"

void SimpleAccordionPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  simple_accordion::SimpleAccordionPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

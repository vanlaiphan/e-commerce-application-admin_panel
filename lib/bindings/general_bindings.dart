import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/controllers/settings_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/helpers/network_manager.dart';

import '../features/authentication/controllers/user_controller.dart';

class GeneralBindings extends Bindings{

  @override
  void dependencies() {
    /// -- Core
    Get.lazyPut(()=>NetworkManager(),fenix: true);
    Get.lazyPut(()=>UserController(),fenix: true);
    Get.lazyPut(()=>SettingsController(),fenix: true);
  }
}
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/screens/settings/responsive_screens/settings_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/screens/settings/responsive_screens/settings_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/screens/settings/responsive_screens/settings_tablet.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: SettingsDesktopScreen(),
      tablet: SettingsTabletScreen(),
      mobile: SettingsMobileScreen(),
    );
  }
}

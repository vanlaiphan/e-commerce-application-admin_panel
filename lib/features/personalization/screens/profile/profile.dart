import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/screens/profile/responsive_screens/profile_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/screens/profile/responsive_screens/profile_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/screens/profile/responsive_screens/profile_tablet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: ProfileDesktopScreen(),
      tablet: ProfileTabletScreen(),
      mobile: ProfileMobileScreen(),
    );
  }
}

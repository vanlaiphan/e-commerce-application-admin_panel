import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/customer/all_customers/responsive_screens/customer_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/customer/all_customers/responsive_screens/customer_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/customer/all_customers/responsive_screens/customer_tablet.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: CustomersDesktopScreen(), tablet: CustomersTabletScreen(), mobile: CustomersMobileScreen());
  }
}

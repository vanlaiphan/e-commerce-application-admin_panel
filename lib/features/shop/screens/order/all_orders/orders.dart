import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/order/all_orders/responsive_screens/orders_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/order/all_orders/responsive_screens/orders_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/order/all_orders/responsive_screens/orders_tablet.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: OrdersDesktopScreen(),
      tablet: OrdersTabletScreen(),
      mobile: OrdersMobileScreen(),
    );
  }
}

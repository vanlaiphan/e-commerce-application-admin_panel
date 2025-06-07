import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/create_category/responsive_screens/create_category_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/create_category/responsive_screens/create_category_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/create_category/responsive_screens/create_category_tablet.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: CreateCategoryDesktopScreen(),
      tablet: CreateCategoryTabletScreen(),
      mobile: CreateCategoryMobileScreen(),
    );
  }
}

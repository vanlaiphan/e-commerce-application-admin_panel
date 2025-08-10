import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/edit_category/responsive_screens/edit_category_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/edit_category/responsive_screens/edit_category_mobile.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/category/edit_category/responsive_screens/edit_category_tablet.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import '../../../controllers/category/edit_category_controller.dart';
import '../../../models/category_model.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditCategoryController());
    final category = Get.arguments as CategoryModel? ?? CategoryModel.empty();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.init(category);
    });
    return TSiteTemplate(
      desktop: EditCategoryDesktopScreen(category: category),
      tablet: EditCategoryTabletScreen(category: category),
      mobile: EditCategoryMobileScreen(category: category),
    );
  }
}

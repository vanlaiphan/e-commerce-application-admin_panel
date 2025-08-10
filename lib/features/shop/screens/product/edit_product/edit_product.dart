import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/edit_product/responsive_screens/edit_product_desktop.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/screens/product/edit_product/responsive_screens/edit_product_mobile.dart';

import '../../../controllers/product/edit_product_controller.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());
    final product = Get.arguments;
    // controller.initProductData(product);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initProductData(product);
    });

    return TSiteTemplate(desktop: EditProductDesktopScreen(product: product), mobile: EditProductMobileScreen(product: product));
  }
}
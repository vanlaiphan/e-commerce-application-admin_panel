import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/edit_product_controller.dart';

class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = EditProductController.instance;

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visibility Header
          Text('Visibility', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Radio buttons for product visibility - Wrap với Obx
          Obx(
            () => Column(
              children: [
                _buildVisibilityRadioButton(controller, ProductVisibility.published, 'Published'),
                _buildVisibilityRadioButton(controller, ProductVisibility.hidden, 'Hidden'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method - Thêm controller parameter và sử dụng controller.productVisibility.value
  Widget _buildVisibilityRadioButton(EditProductController controller, ProductVisibility value, String label) {
    return RadioMenuButton<ProductVisibility>(
      value: value,
      groupValue: controller.productVisibility.value, // Sử dụng controller thay vì hardcode
      onChanged: (selection) {
        if (selection != null) {
          controller.productVisibility.value = selection; // Cập nhật controller
        }
      },
      child: Text(label),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/models/address_model.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/controllers/customer/customer_detail_controller.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/sizes.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    controller.getCustomerAddresses();

    return Obx(
      () {
        if (controller.addressesLoading.value) return const TLoaderAnimation();

        AddressModel selectedAddress = AddressModel.empty();
        if (controller.customer.value.addresses != null) {
          if (controller.customer.value.addresses!.isNotEmpty) {
            selectedAddress = controller.customer.value.addresses!.where((element) => element.selectedAddress).single;
          }
        }

        return TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Address', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Meta Data
              Row(
                children: [
                  const SizedBox(width: 120, child: Text('Name')),
                  const Text(':'),
                  const SizedBox(width: TSizes.spaceBtwItems / 2),
                  Expanded(child: Text(selectedAddress.name, style: Theme.of(context).textTheme.titleMedium)),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              Row(
                children: [
                  const SizedBox(width: 120, child: Text('Country')),
                  const Text(':'),
                  const SizedBox(width: TSizes.spaceBtwItems / 2),
                  Expanded(child: Text(selectedAddress.country, style: Theme.of(context).textTheme.titleMedium)),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              Row(
                children: [
                  const SizedBox(width: 120, child: Text('Phone Number')),
                  const Text(':'),
                  const SizedBox(width: TSizes.spaceBtwItems / 2),
                  Expanded(child: Text(selectedAddress.phoneNumber, style: Theme.of(context).textTheme.titleMedium)),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              Row(
                children: [
                  const SizedBox(width: 120, child: Text('Address')),
                  const Text(':'),
                  const SizedBox(width: TSizes.spaceBtwItems / 2),
                  Expanded(
                    child: Text(
                      selectedAddress.id.isNotEmpty ? selectedAddress.toString() : '',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

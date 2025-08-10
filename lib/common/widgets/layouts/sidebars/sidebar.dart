import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/images/t_circular_image.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/controllers/settings_controller.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import '../../../../routes/routes.dart';
import 'menu/menu_item.dart';



class TSidebar extends StatelessWidget {
  const TSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          color: TColors.white,
          border: Border(right: BorderSide(width: 1, color: TColors.grey)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image
              Padding(
                padding: const EdgeInsets.symmetric(vertical: TSizes.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => TCircularImage(
                        width: 60,
                        height: 60,
                        padding: 0,
                        backgroundColor: Colors.transparent,
                        imageType: SettingsController.instance.settings.value.appLogo.isNotEmpty ? ImageType.network : ImageType.asset,
                        image: SettingsController.instance.settings.value.appLogo.isNotEmpty
                            ? SettingsController.instance.settings.value.appLogo
                            : TImages.darkAppLogo,
                      ),
                    ),
                    const SizedBox(width: TSizes.sm),
                    Flexible(
                      child: Obx(
                        () => Text(
                          SettingsController.instance.settings.value.appName,
                          style: Theme.of(context).textTheme.headlineLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.all(TSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('MENU', style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2)),

                    // Menu Items
                    const TMenuItem(route: TRoutes.dashboard, icon: Iconsax.status, itemName: 'Dashboard'),
                    const TMenuItem(route: TRoutes.media, icon: Iconsax.image, itemName: 'Media'),
                    const TMenuItem(route: TRoutes.categories, icon: Iconsax.category_2, itemName: 'Categories'),
                    const TMenuItem(route: TRoutes.brands, icon: Iconsax.dcube, itemName: 'Brands'),
                    const TMenuItem(route: TRoutes.banners, icon: Iconsax.picture_frame, itemName: 'Banners'),
                    const TMenuItem(route: TRoutes.products, icon: Iconsax.shopping_bag, itemName: 'Products'),
                    const TMenuItem(route: TRoutes.customers, icon: Iconsax.profile_2user, itemName: 'Customers'),
                    const TMenuItem(route: TRoutes.orders, icon: Iconsax.box, itemName: 'Orders'),
                    const TMenuItem(route: TRoutes.profile, icon: Iconsax.user, itemName: 'Profile'),
                    const TMenuItem(route: TRoutes.settings, icon: Iconsax.setting_2, itemName: 'Settings'),
                    const TMenuItem(route: '/logout', icon: Iconsax.logout, itemName: 'Logout'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

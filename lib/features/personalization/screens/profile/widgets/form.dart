import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/features/authentication/controllers/user_controller.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';







class ProfileForm extends StatefulWidget {
  const ProfileForm({
    super.key,
  });

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Khởi tạo giá trị controller sau khi build hoàn thành
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeControllers();
    });
  }

  void _initializeControllers() {
    if (!_isInitialized && mounted) {
      final controller = UserController.instance;

      // Kiểm tra xem user data đã được load chưa và id không null
      if (controller.user.value.id?.isNotEmpty == true) {
        controller.firstNameController.text = controller.user.value.firstName;
        controller.lastNameController.text = controller.user.value.lastName;
        controller.phoneController.text = controller.user.value.phoneNumber;
        _isInitialized = true;

        // Trigger rebuild để cập nhật UI
        if (mounted) {
          setState(() {});
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = UserController.instance;

      // Khởi tạo controllers khi user data đã sẵn sàng
      if (!_isInitialized && controller.user.value.id?.isNotEmpty == true) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _initializeControllers();
        });
      }

      return Column(
        children: [
          TRoundedContainer(
            padding: const EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Profile Details', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: TSizes.spaceBtwSections),

                // First and Last Name
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // First Name
                          Expanded(
                            child: TextFormField(
                              controller: controller.firstNameController,
                              decoration: const InputDecoration(
                                hintText: 'First Name',
                                label: Text('First Name'),
                                prefixIcon: Icon(Iconsax.user),
                              ),
                              validator: (value) => TValidator.validateEmptyText('First Name', value),
                            ),
                          ),
                          const SizedBox(width: TSizes.spaceBtwInputFields),
                          // Last Name
                          Expanded(
                            child: TextFormField(
                              controller: controller.lastNameController,
                              decoration: const InputDecoration(
                                hintText: 'Last Name',
                                label: Text('Last Name'),
                                prefixIcon: Icon(Iconsax.user),
                              ),
                              validator: (value) => TValidator.validateEmptyText('Last Name', value),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),

                      // Email and Phone
                      Row(
                        children: [
                          // Email
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                label: Text('Email'),
                                prefixIcon: Icon(Iconsax.forward),
                              ),
                              initialValue: controller.user.value.email ?? '',
                              readOnly: true,
                            ),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          // Phone Number
                          Expanded(
                            child: TextFormField(
                              controller: controller.phoneController,
                              decoration: const InputDecoration(
                                hintText: 'Phone Number',
                                label: Text('Phone Number'),
                                prefixIcon: Icon(Iconsax.mobile),
                              ),
                              validator: (value) => TValidator.validateEmptyText('Phone Number', value),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.loading.value ? null : () => _updateUserInformation(controller),
                    child: controller.loading.value
                        ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        : const Text('Update Profile'),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }

  void _updateUserInformation(UserController controller) {
    if (_formKey.currentState!.validate()) {
      controller.updateUserInformation();
    }
  }

  @override
  void dispose() {
    // Không dispose controllers ở đây vì chúng được quản lý bởi UserController
    super.dispose();
  }
}

// class ProfileForm extends StatelessWidget {
//   const ProfileForm({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = UserController.instance;
//     controller.firstNameController.text = controller.user.value.firstName;
//     controller.lastNameController.text = controller.user.value.lastName;
//     controller.phoneController.text = controller.user.value.phoneNumber;
//
//     return Column(
//       children: [
//         TRoundedContainer(
//           padding: const EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Profile Details', style: Theme.of(context).textTheme.headlineSmall),
//               const SizedBox(height: TSizes.spaceBtwSections),
//
//               // First and Last Name
//               Form(
//                 key: controller.formKey,
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         // First Name
//                         Expanded(
//                           child: TextFormField(
//                             controller: controller.firstNameController,
//                             decoration: const InputDecoration(
//                               hintText: 'First Name',
//                               label: Text('First Name'),
//                               prefixIcon: Icon(Iconsax.user),
//                             ),
//                             validator: (value) => TValidator.validateEmptyText('First Name', value),
//                           ),
//                         ),
//                         const SizedBox(width: TSizes.spaceBtwInputFields),
//                         // Last Name
//                         Expanded(
//                           child: TextFormField(
//                             controller: controller.lastNameController,
//                             decoration: const InputDecoration(
//                               hintText: 'Last Name',
//                               label: Text('Last Name'),
//                               prefixIcon: Icon(Iconsax.user),
//                             ),
//                             validator: (value) => TValidator.validateEmptyText('Last Name', value),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: TSizes.spaceBtwInputFields),
//
//                     // Email and Phone
//                     Row(
//                       children: [
//                         // First Name
//                         Expanded(
//                           child: TextFormField(
//                             decoration: const InputDecoration(
//                               hintText: 'Email',
//                               label: Text('Email'),
//                               prefixIcon: Icon(Iconsax.forward),
//                               // enabled: false,
//                             ),
//                             initialValue: UserController.instance.user.value.email,
//                           ),
//                         ),
//                         const SizedBox(width: TSizes.spaceBtwItems),
//                         // Last Name
//                         Expanded(
//                           child: TextFormField(
//                             controller: controller.phoneController,
//                             decoration: const InputDecoration(
//                               hintText: 'Phone Number',
//                               label: Text('Phone Number'),
//                               prefixIcon: Icon(Iconsax.mobile),
//                             ),
//                             validator: (value) => TValidator.validateEmptyText('Phone Number', value),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(height: TSizes.spaceBtwSections),
//
//               SizedBox(
//                 width: double.infinity,
//                 child: Obx(
//                   () => ElevatedButton(
//                     onPressed: () => controller.loading.value ? () {} : controller.updateUserInformation(),
//                     child: controller.loading.value
//                         ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
//                         : const Text('Upload Profile'),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/models/user_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/loaders.dart';

import '../../../utils/helpers/network_manager.dart';
import '../../media/controllers/media_controller.dart';
import '../../media/models/image_model.dart';



class UserController extends GetxController {
  static UserController get instance => Get.find();

  // Observable variables
  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  // Form controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  // Dependencies
  final userRepository = Get.put(UserRepository());

  // Tracking initialization status
  RxBool isUserDataLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch user details on controller initialization
    fetchUserDetails();
  }

  /// Fetches user details from the repository
  Future<UserModel> fetchUserDetails() async {
    try {
      loading.value = true;
      final userData = await userRepository.fetchAdminDetails();

      // Update user data
      user.value = userData;

      // Initialize controllers with user data
      _initializeControllers();

      // Mark as loaded
      isUserDataLoaded.value = true;
      loading.value = false;

      return userData;
    } catch (e) {
      loading.value = false;
      isUserDataLoaded.value = false;
      TLoaders.errorSnackBar(title: 'Something went wrong.', message: e.toString());
      return UserModel.empty();
    }
  }

  /// Initialize text controllers with user data
  void _initializeControllers() {
    firstNameController.text = user.value.firstName;
    lastNameController.text = user.value.lastName;
    phoneController.text = user.value.phoneNumber;
  }

  /// Pick Thumbnail Image from Media
  void updateProfilePicture() async {
    try {
      loading.value = true;
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

      // Handle the selected images
      if (selectedImages != null && selectedImages.isNotEmpty) {
        // Set the selected image to the main image or perform any other action
        ImageModel selectedImage = selectedImages.first;

        // Update Profile in FireStore
        await userRepository.updateSingleField({'ProfilePicture': selectedImage.url});

        // Update the main image using the selectedImage
        user.value.profilePicture = selectedImage.url;
        user.refresh();
        TLoaders.successSnackBar(title: 'Congratulations', message: 'Your Profile Picture has been updated.');
      }

      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void updateUserInformation() async {
    try {
      loading.value = true;

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        loading.value = false;
        TLoaders.errorSnackBar(title: 'No Internet', message: 'Please check your internet connection.');
        return;
      }

      // Update user model with form data
      user.value.firstName = firstNameController.text.trim();
      user.value.lastName = lastNameController.text.trim();
      user.value.phoneNumber = phoneController.text.trim();

      // Update in repository
      await userRepository.updateUserDetails(user.value);

      // Refresh user data
      user.refresh();

      loading.value = false;
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your Profile has been updated.');
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Reset controllers to current user data
  void resetControllers() {
    _initializeControllers();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}

// class UserController extends GetxController {
//   static UserController get instance => Get.find();
//
//   // Observable variables
//   RxBool loading = false.obs;
//   Rx<UserModel> user = UserModel.empty().obs;
//
//   final formKey = GlobalKey<FormState>();
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final phoneController = TextEditingController();
//
//   // Dependencies
//   final userRepository = Get.put(UserRepository());
//
//   @override
//   void onInit() {
//     // Fetch user details on controller initialization
//     fetchUserDetails();
//     super.onInit();
//   }
//
//   /// Fetches user details from the repository
//   Future<UserModel> fetchUserDetails() async {
//     try {
//       loading.value = true;
//       final user = await userRepository.fetchAdminDetails();
//       this.user.value = user;
//       loading.value = false;
//
//       return user;
//     } catch (e) {
//       TLoaders.errorSnackBar(title: 'Something went wrong.', message: e.toString());
//       return UserModel.empty();
//     }
//   }
//
//   /// Pick Thumbnail Image from Media
//   void updateProfilePicture() async {
//     try {
//       loading.value = true;
//       final controller = Get.put(MediaController());
//       List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();
//
//       // Handle the selected images
//       if (selectedImages != null && selectedImages.isNotEmpty) {
//         // Set the selected image to the main image or perform any other action
//         ImageModel selectedImage = selectedImages.first;
//
//         // Update Profile in FireStore
//         await userRepository.updateSingleField({'ProfilePicture': selectedImage.url});
//
//         // Update the main image using the selectedImage
//         user.value.profilePicture = selectedImage.url;
//         user.refresh();
//         TLoaders.successSnackBar(title: 'Congratulations', message: 'Your Profile Picture has been updated.');
//       }
//
//       loading.value = false;
//     } catch (e) {
//       loading.value = false;
//       TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
//     }
//   }
//
//   void updateUserInformation() async {
//     try {
//       loading.value = true;
//       // Check Internet Connectivity
//       final isConnected = await NetworkManager.instance.isConnected();
//       if (!isConnected) {
//         TFullScreenLoader.stopLoading();
//         return;
//       }
//
//       // Form Validation
//       if (!formKey.currentState!.validate()) {
//         TFullScreenLoader.stopLoading();
//         return;
//       }
//
//       user.value.firstName = firstNameController.text.trim();
//       user.value.lastName = lastNameController.text.trim();
//       user.value.phoneNumber = phoneController.text.trim();
//
//       await userRepository.updateUserDetails(user.value);
//       user.refresh();
//
//       loading.value = false;
//       TLoaders.successSnackBar(title: 'Congratulations', message: 'Your Profile has been updated.');
//     } catch (e) {
//       loading.value = false;
//       TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
//     }
//   }
// }

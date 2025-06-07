import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../features/personalization/models/address_model.dart';
import '../authentication/authentication_repository.dart';

class AddressRepository extends GetxController {
  // Get instance of AddressRepository using Get.find()
  static AddressRepository get instance => Get.find();

  // Firebase FireStore instance
  final _db = FirebaseFirestore.instance;

  // Fetch user addresses from FireStore based on userId
  Future<List<AddressModel>> fetchUserAddresses(String userId) async {
    try {
      // Query FireStore collection to get user addresses
      final result = await _db.collection('Users').doc(userId).collection('Addresses').get();
      // Convert FireStore document snapshots to AddressModel objects
      return result.docs.map((documentSnapshot) => AddressModel.fromDocumentSnapshot(documentSnapshot)).toList();
    } catch (e) {
      // Throw an error if fetching addresses fails
      throw 'Something went wrong while fetching Address Information. Try again later';
    }
  }

  // Update the "SelectedAddress" field for a specific address
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      // Get the current user's ID
      final userId = AuthenticationRepository.instance.authUser!.uid;
      // Update the selected field for the specified address in FireStore
      await _db.collection('Users').doc(userId).collection('Addresses').doc(addressId).update({'SelectedAddress': selected});
    } catch (e) {
      // Throw an error if updating address selection fails
      throw 'Unable to update your address selection. Try again later';
    }
  }
}

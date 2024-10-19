import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileController extends GetxController {
  final _box = GetStorage();
  RxString profilePicture = ''.obs;
  RxString password = ''.obs;

  // Method to load the profile data from storage
  void loadProfileData() {
    profilePicture.value = _box.read('profile_picture') ?? '';
    password.value = _box.read('password') ?? '';
  }

  // Method to update the password
  void updatePassword(String newPassword, String text) {
    password.value = newPassword;
    _box.write('password', newPassword); // Save to storage
  }

  // Method to update the profile picture
  Future<void> updateProfilePicture() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profilePicture.value = image.path;
      _box.write('profile_picture', image.path); // Save the path in storage
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadProfileData(); // Load profile picture and password on init
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_settings_controller.dart';


class ProfileSettingsPage extends StatelessWidget {
  final ProfileController _profileController = Get.put(ProfileController());

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Obx(() => CircleAvatar(
                radius: 50,
                backgroundImage: _profileController.profilePicture.value.isEmpty
                    ? const AssetImage('assets/default_avatar.png')
                    : FileImage(File(_profileController.profilePicture.value)) as ImageProvider,
              )),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _profileController.updateProfilePicture();
                },
                child: const Text('Change Profile Picture'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _oldPasswordController,
                decoration: const InputDecoration(labelText: 'Old Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your old password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _newPasswordController,
                decoration: const InputDecoration(labelText: 'New Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Confirm New Password'),
                obscureText: true,
                validator: (value) {
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Call updatePassword with the old and new passwords
                    _profileController.updatePassword(
                      _oldPasswordController.text,
                      _newPasswordController.text,
                    );
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

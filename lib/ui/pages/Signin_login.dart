import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/ui/theme.dart';
import 'package:untitled/ui/widgets/button.dart';
import 'dart:io';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  String? _uploadedPhotoPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildInputField(
                label: "Name",
                controller: _nameController,
                hintText: "Enter your name",
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: "Username",
                controller: _usernameController,
                hintText: "Enter your username",
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: "Email",
                controller: _emailController,
                hintText: "Enter your email",
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: "Password",
                controller: _passwordController,
                hintText: "Enter your password",
                obscureText: true,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: "Re-enter Password",
                controller: _rePasswordController,
                hintText: "Re-enter your password",
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Center(child: _buildPhotoUploadField()), // Center the photo upload
              const SizedBox(height: 30),
              Center( // Center the button
                child: MyButton(
                  label: "Sign In",
                  onTap: () {
                    _submitForm();
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You already have an account? ",
                      style: subTitleStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const LoginPage()); // Navigate to login page
                      },
                      child: Text(
                        "Log in",
                        style: subTitleStyle.copyWith(
                          color: primaryClr,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Sign In", style: headingStyle),
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back, color: Get.isDarkMode ? Colors.white : darkGreyClr),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: subTitleStyle),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: subTitleStyle,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: primaryClr),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoUploadField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Upload Photo", style: subTitleStyle),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _uploadPhoto,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey),
            ),
            child: _uploadedPhotoPath == null
                ? Icon(Icons.add_a_photo, color: Colors.grey[600], size: 40)
                : Image.file(
              File(_uploadedPhotoPath!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  void _uploadPhoto() async {
    // Implement logic to upload photo
    // Use image picker to get photo and update _uploadedPhotoPath
  }

  void _submitForm() {
    if (_passwordController.text != _rePasswordController.text) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[300],
        colorText: Colors.white,
      );
    } else {
      // Handle form submission logic (e.g., API call)
      Get.snackbar(
        "Success",
        "Account created successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[300],
        colorText: Colors.white,
      );
    }
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Log In", style: headingStyle),
        backgroundColor: context.theme.colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildInputField(
              label: "Email",
              controller: emailController,
              hintText: "Enter your email",
            ),
            const SizedBox(height: 20),
            _buildInputField(
              label: "Password",
              controller: passwordController,
              hintText: "Enter your password",
              obscureText: true,
            ),
            const SizedBox(height: 30),
            MyButton(
              label: "Log In",
              onTap: () {
                // Handle login logic
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: subTitleStyle),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: subTitleStyle,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: primaryClr),
            ),
          ),
        ),
      ],
    );
  }
}

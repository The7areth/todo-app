import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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

  // Regular expression to validate email format
  final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

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
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  child: const Text("Sign In"),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("You already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const LoginPage()); // Navigate to the login page
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.blue,
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
      title: const Text("Sign In"),
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back, color: Get.isDarkMode ? Colors.white : Colors.grey),
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
        Text(label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue),
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
        const Text("Upload Photo"),
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
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _uploadedPhotoPath = image.path;
      });
    } else {
      print("No image selected");
    }
  }

  void _submitForm() {
    if (_nameController.text.isEmpty) {
      _showErrorSnackbar("Name field is required");
    } else if (_usernameController.text.isEmpty) {
      _showErrorSnackbar("Username field is required");
    } else if (_emailController.text.isEmpty) {
      _showErrorSnackbar("Email field is required");
    } else if (!emailRegExp.hasMatch(_emailController.text)) {
      _showErrorSnackbar("Please enter a valid email address");
    } else if (_passwordController.text.isEmpty) {
      _showErrorSnackbar("Password field is required");
    } else if (_rePasswordController.text.isEmpty) {
      _showErrorSnackbar("Please confirm your password");
    } else if (_passwordController.text != _rePasswordController.text) {
      _showErrorSnackbar("Passwords do not match");
    } else {
      Get.snackbar(
        "Success",
        "Account created successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[300],
        colorText: Colors.white,
      );
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red[300],
      colorText: Colors.white,
    );
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
        title: const Text("Log In"),
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
            ElevatedButton(
              onPressed: () {
                // Handle login logic here
              },
              child: const Text("Log In"),
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
        Text(label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}

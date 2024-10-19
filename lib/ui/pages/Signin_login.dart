import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< HEAD
import 'package:image_picker/image_picker.dart';
=======
import 'package:untitled/ui/theme.dart';
import 'package:untitled/ui/widgets/button.dart';
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
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

<<<<<<< HEAD
  // Regular expression to validate email format
  final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

=======
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
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
<<<<<<< HEAD
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  child: const Text("Sign In"),
=======
              Center( // Center the button
                child: MyButton(
                  label: "Sign In",
                  onTap: () {
                    _submitForm();
                  },
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
<<<<<<< HEAD
                    const Text("You already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const LoginPage()); // Navigate to the login page
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.blue,
=======
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
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
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
<<<<<<< HEAD
      title: const Text("Sign In"),
=======
      title: Text("Sign In", style: headingStyle),
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
<<<<<<< HEAD
        icon: Icon(Icons.arrow_back, color: Get.isDarkMode ? Colors.white : Colors.grey),
=======
        icon: Icon(Icons.arrow_back, color: Get.isDarkMode ? Colors.white : darkGreyClr),
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
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
<<<<<<< HEAD
        Text(label),
=======
        Text(label, style: subTitleStyle),
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
<<<<<<< HEAD
          decoration: InputDecoration(
            hintText: hintText,
=======
          style: subTitleStyle,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
<<<<<<< HEAD
              borderSide: const BorderSide(color: Colors.blue),
=======
              borderSide: const BorderSide(color: primaryClr),
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
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
<<<<<<< HEAD
        const Text("Upload Photo"),
=======
        Text("Upload Photo", style: subTitleStyle),
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
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
<<<<<<< HEAD
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
=======
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
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
      Get.snackbar(
        "Success",
        "Account created successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[300],
        colorText: Colors.white,
      );
    }
  }
<<<<<<< HEAD

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red[300],
      colorText: Colors.white,
    );
  }
=======
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: const Text("Log In"),
=======
        title: Text("Log In", style: headingStyle),
        backgroundColor: context.theme.colorScheme.background,
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
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
<<<<<<< HEAD
            ElevatedButton(
              onPressed: () {
                // Handle login logic here
              },
              child: const Text("Log In"),
=======
            MyButton(
              label: "Log In",
              onTap: () {
                // Handle login logic
              },
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
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
<<<<<<< HEAD
        Text(label),
=======
        Text(label, style: subTitleStyle),
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
<<<<<<< HEAD
          decoration: InputDecoration(
            hintText: hintText,
=======
          style: subTitleStyle,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
<<<<<<< HEAD
              borderSide: const BorderSide(color: Colors.blue),
=======
              borderSide: const BorderSide(color: primaryClr),
>>>>>>> 3228cf64149e5868d9b162b36e51efef35ac2200
            ),
          ),
        ),
      ],
    );
  }
}

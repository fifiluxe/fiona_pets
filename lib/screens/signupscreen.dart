// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/mybutton.dart';
import 'package:flutter_application_1/widgets/mytextfield.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var store = GetStorage();

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool rememberMe = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String phone = phoneController.text.trim();
    final String password = passwordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      // Use POST method to send data
      var url = Uri.parse("http://localhost/petadoption/signup.php");

      var response = await http.post(
        url,
        body: {
          "username": name,
          "email": email,
          "phone_number": phone,
          "password": password, // Send plain password (handled in PHP)
        },
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 && responseBody['success'] == 1) {
        if (rememberMe) {
          store.write("username", name);
          store.write("email", email);
        } else {
          store.remove("username");
          store.remove("email");
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseBody['message']),
            duration: const Duration(seconds: 2),
          ),
        );
        nameController.clear();
        emailController.clear();
        phoneController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        Get.back(); // Return to LoginScreen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseBody['message'] ?? 'Registration failed'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        // ignore: deprecated_member_use
        backgroundColor: Colors.teal.withOpacity(0.7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Return to LoginScreen
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bird.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset("images/cute.jpg", height: 100),
                const SizedBox(height: 20),
                const Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                myTextField(
                  hintText: "Enter username",
                  controller: nameController,
                  fillColor: Colors.white,
                  textColor: Colors.black,
                  hintTextColor: Colors.grey,
                ),
                const SizedBox(height: 20),
                myTextField(
                  hintText: "Enter email",
                  controller: emailController,
                  fillColor: Colors.white,
                  textColor: Colors.black,
                  hintTextColor: Colors.grey,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                myTextField(
                  hintText: "Enter phone number",
                  controller: phoneController,
                  fillColor: Colors.white,
                  textColor: Colors.black,
                  hintTextColor: Colors.grey,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                myTextField(
                  hintText: "Enter password",
                  controller: passwordController,
                  fillColor: Colors.white,
                  textColor: Colors.black,
                  hintTextColor: Colors.grey,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                myTextField(
                  hintText: "Confirm password",
                  controller: confirmPasswordController,
                  fillColor: Colors.white,
                  textColor: Colors.black,
                  hintTextColor: Colors.grey,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value ?? false;
                        });
                      },
                    ),
                    const Text(
                      "Remember Me",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                myButton(
                  _registerUser,
                  label: "Create Account",
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

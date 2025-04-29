// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/mycolors.dart';
import 'package:flutter_application_1/controller/logincontroller.dart';
import 'package:flutter_application_1/screens/signupscreen.dart';
import 'package:flutter_application_1/widgets/mybutton.dart';
import 'package:flutter_application_1/widgets/mytextfield.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

var store = GetStorage();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    usernameController.text = store.read("username") ?? "";
    emailController.text = store.read("email") ?? "";
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.teal.withOpacity(0.7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAllNamed('/'); // Return to Homescreen
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
                  'Login',
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
                  controller: usernameController,
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
                myButton(
                  () async {
                    String username = usernameController.text.trim();
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();

                    if ((username.isEmpty && email.isEmpty) ||
                        password.isEmpty) {
                      loginController.setMessage(
                        "Please provide username or email and password",
                      );
                    } else {
                      try {
                        var url = Uri.http(
                          "localhost",
                          "/petadoption/login.php",
                        );

                        var response = await http.post(
                          url,
                          headers: {
                            "Content-Type": "application/x-www-form-urlencoded",
                          },
                          body: {
                            if (username.isNotEmpty) "username": username,
                            if (email.isNotEmpty) "email": email,
                            "password": password,
                          },
                        );

                        if (response.statusCode == 200) {
                          var responseBody = jsonDecode(response.body);
                          if (responseBody["success"] == 1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('You are logged in'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Get.toNamed('/pets');
                            loginController.setMessage(
                              "Logged in successfully",
                            );
                          } else {
                            loginController.setMessage(
                              responseBody["message"] ?? "Invalid login",
                            );
                          }
                        } else {
                          loginController.setMessage(
                            "Server error: ${response.statusCode}",
                          );
                        }
                      } catch (e) {
                        loginController.setMessage("Error: $e");
                      }
                    }
                  },
                  label: "Login",
                  color: SecondaryColor,
                ),
                const SizedBox(height: 30),
                myButton(
                  () {
                    Get.to(() => const SignUpScreen());
                  },
                  label: "SignUp",
                  color: Colors.blue,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                          color: mainColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () {
                        // Add forgot password logic here
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Obx(
                  () => Text(
                    loginController.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

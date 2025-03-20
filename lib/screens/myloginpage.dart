import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/mycolors.dart';
import 'package:flutter_application_1/widgets/mybutton.dart';
import 'package:flutter_application_1/widgets/mytextfield.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/logo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 20, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/logo.jpg", height: 100),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              myTextField(
                hintText: "Enter username",
                controller: userNameController,
                fillColor: Colors.white,
                textColor: Colors.white,
                hintTextColor: Colors.white,
              ),
              SizedBox(height: 20),
              myTextField(
                hintText: "Enter password",
                controller: passwordController,
                fillColor: Colors.white,
                textColor: Colors.white,
                hintTextColor: Colors.white,
              ),
              SizedBox(height: 30),
              myButton(
                () {
                  print("Login");
                },
                label: "Login",
                color: SecondaryColor,
              ),
              SizedBox(height: 30),
              myButton(
                () {
                  print("SignUp");
                },
                label: "SignUp",
                color: Colors.deepOrange,
              ),

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
                      print("password recovered");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

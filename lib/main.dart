import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/views/homescreen.dart';
import 'package:flutter_application_1/views/dashboard.dart';
import 'package:flutter_application_1/screens/myloginpage.dart';
import 'package:flutter_application_1/views/pets.dart';
import 'package:flutter_application_1/views/orders.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Msic Instruments',
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Homescreen()),
        GetPage(name: '/dashboard', page: () => const Dashboard()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/products', page: () => const Pets()),
        GetPage(name: '/orders', page: () => const Orders()),
      ],
    );
  }
}

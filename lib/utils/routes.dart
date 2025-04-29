import 'package:flutter_application_1/screens/myloginpage.dart';
import 'package:flutter_application_1/views/homescreen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage> routes = [
  GetPage(name: "/", page: () => LoginScreen()),
  GetPage(name: "/homescreen", page: () => Homescreen()),
];

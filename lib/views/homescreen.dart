import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/homescreen_controller.dart';
import 'package:flutter_application_1/views/dashboard.dart';
import 'package:flutter_application_1/views/orders.dart';
import 'package:flutter_application_1/views/pets.dart';
import 'package:flutter_application_1/views/profile.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

HomescreenController homescreenController = HomescreenController();
List myScreens = [
  const Dashboard(),
  const Profile(),
  const Pets(),
  const Orders(),
];

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            BottomNavigationBarItem(icon: Icon(Icons.pets), label: "Pets"),
          ],
          unselectedItemColor: Colors.red,
          selectedItemColor: Colors.green,
          backgroundColor: Colors.teal,
          showUnselectedLabels: true,
          currentIndex: homescreenController.selectedScreenIndex.value,
          onTap: (index) {
            if (index == 1) {
              Navigator.pushNamed(context, '/login');
            } else {
              homescreenController.updateSelectedIndex(index);
            }
          },
        ),
      ),
      body: Obx(
        () => myScreens[homescreenController.selectedScreenIndex.value],
      ),
    );
  }
}

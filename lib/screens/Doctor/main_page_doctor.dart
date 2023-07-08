import 'package:flutter/material.dart';
import 'package:health_care/screens/Doctor/doctorSchedulePage.dart';
import 'package:health_care/screens/Doctor/doctor_home_screen.dart';
import 'package:health_care/screens/Doctor/doctor_infor_page.dart';
// import 'package:health_care/screens/general/notification_page.dart';
import '../../components/bottomNavigation.dart';

class MainPageDoctor extends StatefulWidget {
  const MainPageDoctor({super.key});
  @override
  State<MainPageDoctor> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainPageDoctor> {
  int _selectedIndex = 0;

  Widget currentPageDoctor(int index) {
    switch (index) {
      case 0:
        return DoctorHomeScreen();
      case 1:
        return DoctorSchedulePage();
      case 2:
        return DoctorInforPage(true);
      default:
        return DoctorHomeScreen();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: currentPageDoctor(_selectedIndex)),
      bottomNavigationBar: BottomNavBar(_selectedIndex, _onItemTapped),
    );
  }
}

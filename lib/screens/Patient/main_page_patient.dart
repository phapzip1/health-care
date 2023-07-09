import 'package:flutter/material.dart';
import 'patient_home_page.dart';
import './patientSchedulePage.dart';
import '../../components/bottomNavigation.dart';
import '../../screens/Patient/patientInformation.dart';

class MainPagePatient extends StatefulWidget {
  const MainPagePatient({super.key});
  @override
  State<MainPagePatient> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainPagePatient> {
  int _selectedIndex = 0;


  Widget currentPagePatient(int index) {
    switch (index) {
      case 0:
        return PatientHomePage();
      case 1:
        return PatientSchedulePage();
      case 2:
        return PatientInformation();
      default:
        return PatientHomePage();
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
      body: Center(
        child: currentPagePatient(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavBar(_selectedIndex, _onItemTapped),
    );
  }
}

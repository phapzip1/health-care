import 'package:flutter/material.dart';
import 'package:health_care/screens/Doctor/doctorInformation.dart';
import 'package:health_care/screens/Doctor/doctorSchedulePage.dart';
import 'package:health_care/screens/Doctor/homePageDoctor.dart';
import '../../screens/Patient/homePage.dart';
import './patientSchedulePage.dart';
import '../../components/bottomNavigation.dart';
import '../../screens/Patient/patientInformation.dart';

class MainPage extends StatefulWidget {
  final bool isDoctor;
  MainPage(this.isDoctor);
  @override
  State<MainPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainPage> {
  int _selectedIndex = 0;
  
  Widget currentPagePatient(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return PatientSchedulePage();
      case 2:
        return PatientInformation();
      default:
        return HomePage();
    }
  }

  Widget currentPageDoctor(int index) {
    switch (index) {
      case 0:
        return HomePageDoctor();
      case 1:
        return DoctorSchedulePage();
      case 2:
        return DoctorInformation();
      default:
        return HomePageDoctor();
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
        child: widget.isDoctor ? currentPageDoctor(_selectedIndex) : currentPagePatient(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavBar(_selectedIndex, _onItemTapped),
    );
  }
}

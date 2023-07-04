import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care/screens/general/notification_page.dart';
import '../../screens/Patient/homePage.dart';
import './patientSchedulePage.dart';
import '../../components/bottomNavigation.dart';
import '../../screens/Patient/patientInformation.dart';

class MainPagePtient extends StatefulWidget {
  const MainPagePtient({super.key});
  @override
  State<MainPagePtient> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainPagePtient> {
  int _selectedIndex = 0;

  final user = FirebaseAuth.instance.currentUser!.uid;

  Widget currentPagePatient(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return PatientSchedulePage();
      case 2:
        return PatientInformation();
      case 3:
        return NotificationPage();
      default:
        return HomePage();
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

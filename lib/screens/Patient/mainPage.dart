import 'package:flutter/material.dart';
import '../../screens/Doctor/doctorInformation.dart';
import '../../screens/Patient/homePage.dart';
import '../../screens/Patient/medicalReminder.dart';
import '../../screens/Patient/schedulePage.dart';
import '../../components/bottomNavigation.dart';
import '../../screens/Patient/patientInformation.dart';

class PatientMainPage extends StatefulWidget {
  @override
  State<PatientMainPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PatientMainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MedicalReminder(), 
    SchedulePage(),
    // DoctorInformation(),
    PatientInformation()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavBar(_selectedIndex, _onItemTapped),
    );
  }
}

import 'package:flutter/material.dart';
import '../../screens/Patient/homePage.dart';
import './patientSchedulePage.dart';
import '../../components/bottomNavigation.dart';
import '../../screens/Patient/patientInformation.dart';

class PatientMainPage extends StatefulWidget {
  final String id;
  PatientMainPage(this.id);
  @override
  State<PatientMainPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PatientMainPage> {
  int _selectedIndex = 0;

  // final List<Widget> _widgetOptions = <Widget>[
  //   HomePage(),
  //   PatientSchedulePage(),
  //   PatientInformation()
  // ];
  
  Widget currentPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return PatientSchedulePage(widget.id);
      case 2:
        return PatientInformation(widget.id);
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
        child: currentPage(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavBar(_selectedIndex, _onItemTapped),
    );
  }
}

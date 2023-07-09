import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<AppBloc>().add(const AppEventLoadAppointments());
  }

  Widget currentPageDoctor(int index) {
    switch (index) {
      case 0:
        return const DoctorHomeScreen();
      case 1:
        return const DoctorSchedulePage();
      case 2:
        return const DoctorInforPage();
      default:
        return const DoctorHomeScreen();
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

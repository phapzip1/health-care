import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;
  

  BottomNavBar(this.selectedIndex, this.onItemTapped);

  @override
  State<BottomNavBar> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BottomNavBar> {
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/images/calendar.png")),
          label: 'Schedule',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/images/user.png")),
          label: 'Info',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Noti',
        ),
      ],
      showUnselectedLabels: false,
      elevation: 0,
      currentIndex: widget.selectedIndex,
      selectedItemColor: const Color(0xFF3A86FF),
      unselectedItemColor: const Color(0xFF828282),
      onTap: widget.onItemTapped,
    );
  }
}

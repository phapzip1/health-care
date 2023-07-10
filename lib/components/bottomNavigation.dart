import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;
  

  const BottomNavBar(this.selectedIndex, this.onItemTapped);

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
      ],
      showUnselectedLabels: false,
      currentIndex: widget.selectedIndex,
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedItemColor: const Color(0xFF3A86FF),
      unselectedItemColor: const Color(0xFF828282),
      onTap: widget.onItemTapped,
    );
  }
}

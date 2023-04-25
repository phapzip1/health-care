import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;
  

  BottomNavBar(this.selectedIndex, this.onItemTapped);

  @override
  State<BottomNavBar> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BottomNavBar> {
  static const a = true;
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
            AssetImage("assets/images/pill.png")),
          label: 'Medicine',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.solidComments),
          label: 'Q&A',
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
      currentIndex: widget.selectedIndex,
      selectedItemColor: const Color(0xFF3A86FF),
      unselectedItemColor: const Color(0xFF828282),
      onTap: widget.onItemTapped,
    );
  }
}

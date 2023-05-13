import 'package:flutter/material.dart';
import 'package:health_care/widgets/button_section.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Header extends StatefulWidget {
  const Header(this.click, this.changedPage ,{super.key});

  final Function(dynamic value) click;
  final bool changedPage;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(top: 24, right: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Schedule',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                ButtonSection(
                  click: widget.click,
                  status: widget.changedPage,
                  mediaQuery: MediaQuery.of(context),
                  sampleData: [
                    RadioModel(true, "Upcoming", 0),
                    RadioModel(false, "History", 1)
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  widget.changedPage ? 'Nearest visit' : 'Last visit',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          );
  }
}
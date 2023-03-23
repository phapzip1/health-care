import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';

class MedicalReminder extends StatefulWidget {
  const MedicalReminder({super.key});

  @override
  State<MedicalReminder> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MedicalReminder> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('medical'),
    );
  }
}
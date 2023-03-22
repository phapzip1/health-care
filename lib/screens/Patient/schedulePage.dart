import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';


class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Schedule'),
    );
  }
}
import 'package:flutter/material.dart';

// widgets
import './circle_button.dart';

// services

class CallPicking extends StatelessWidget {
  final String cover;
  final String name;
  final void Function() answerFn;

  const CallPicking({
    super.key,
    required this.cover,
    required this.name,
    required this.answerFn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black26),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(cover),
                    radius: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50, left: 70, right: 70),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleButton(
                    onClick: () {
                      // NavigationService.navKey.currentState!.pop();
                      Navigator.of(context).pop();
                    },
                    backgroundColor: Colors.red,
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  CircleButton(
                    onClick: answerFn,
                    backgroundColor: Colors.green,
                    child: const Icon(
                      Icons.videocam,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

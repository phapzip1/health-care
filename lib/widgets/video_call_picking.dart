import "package:flutter/material.dart";

// models
import "../models/call.dart";

class VideoCallPicking extends StatelessWidget {
  const VideoCallPicking({super.key, required this.answerFn, required this.endCallFn, required this.call});

  final void Function() answerFn;
  final void Function() endCallFn;
  final Call call;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black26,
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(call.callerCover),
                    radius: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    call.callerName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
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
                  IconButton(
                    onPressed: () {},
                    color: const Color(0xFFEB5757),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    color: const Color(0xFF4CAF50),
                    icon: const Icon(
                      Icons.videocam_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import "package:flutter/material.dart";

class VideoCallPanel extends StatelessWidget {
  final Future<void> Function() toggleMicFn;
  final Future<void> Function() toggleCamFn;
  final Future<void> Function() switchCamFn;
  final Future<void> Function() endCallFn;

  final bool cam;
  final bool mic;

  const VideoCallPanel({
    super.key,
    required this.toggleMicFn,
    required this.toggleCamFn,
    required this.switchCamFn,
    required this.endCallFn,
    required this.mic,
    required this.cam,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.black12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                color: Colors.transparent,
                padding: const EdgeInsets.all(12),
                onPressed: toggleCamFn,
                icon: Icon(
                  cam ? Icons.videocam : Icons.videocam_off,
                  color: cam ? Colors.white : Colors.grey,
                ),
              ),
              IconButton(
                color: Colors.transparent,
                padding: const EdgeInsets.all(12),
                onPressed: toggleMicFn,
                icon: Icon(
                  mic ? Icons.mic : Icons.mic_off,
                  color: mic ? Colors.white : Colors.grey,
                ),
              ),
              IconButton(
                color: Colors.transparent,
                padding: const EdgeInsets.all(12),
                onPressed: switchCamFn,
                icon: const Icon(
                  Icons.cameraswitch,
                  color: Colors.white,
                ),
              ),
              IconButton(
                color: Colors.red,
                padding: const EdgeInsets.all(12),
                onPressed: endCallFn,
                icon: const Icon(
                  Icons.call_end,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

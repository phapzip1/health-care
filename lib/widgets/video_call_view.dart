import "package:flutter/material.dart";

import "package:agora_rtc_engine/agora_rtc_engine.dart";

class VideoCallView extends StatelessWidget {
  const VideoCallView({
    super.key,
    required this.engine,
    required this.channelId,
    required this.remoteName,
    required this.remoteCover,
    required this.remoteUid,
    required this.localUid,
    required this.remoteMute,
    required this.remoteCamoff,
    required this.localCamoff,
  });

  final RtcEngine engine;
  final String channelId;
  final int remoteUid;
  final int localUid;
  final String remoteName;
  final String remoteCover;
  final bool remoteMute;
  final bool remoteCamoff;
  final bool localCamoff;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // remote
        if (remoteUid != -1)
          Positioned.fill(
            child: AgoraVideoView(
              controller: VideoViewController.remote(
                rtcEngine: engine,
                canvas: VideoCanvas(uid: remoteUid),
                connection: RtcConnection(channelId: channelId),
              ),
            ),
          ),
        // remote cam off
        if (remoteUid != -1 && remoteCamoff)
          Container(
            decoration: const BoxDecoration(color: Colors.brown),
            child: Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundImage: NetworkImage(remoteCover),
                radius: 50,
              ),
            ),
          ),
        // local
        if (remoteUid != -1 && !localCamoff)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              width: 100,
              height: 200,
              child: AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: engine,
                  canvas: VideoCanvas(uid: localUid),
                ),
              ),
            ),
          ),
        // remote muted
        if (remoteMute && remoteUid != -1)
          const Positioned(
            top: 10,
            left: 10,
            child: Icon(
              Icons.mic_off,
              color: Colors.red,
            ),
          ),
        // local preview
        if (remoteUid == -1)
          Positioned.fill(
            child: AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: engine,
                canvas: const VideoCanvas(uid: 0),
              ),
            ),
          ),
        // modal
        if (remoteUid == -1)
          Container(
            decoration: const BoxDecoration(color: Colors.black38),
            child: Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(remoteCover),
                      radius: 50,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      remoteName,
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
          )
      ],
    );
  }
}

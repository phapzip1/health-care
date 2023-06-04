import "package:flutter/material.dart";

import "package:agora_rtc_engine/agora_rtc_engine.dart";
import "package:permission_handler/permission_handler.dart";

import "../models/call.dart";

// widgets
import "../widgets/video_call_picking.dart";
import "../widgets/video_call_view.dart";
import '../widgets/video_call_panel.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({
    super.key,
    required this.caller,
    required this.call,
  });
  final bool caller;
  final Call call;

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final RtcEngine _engine = createAgoraRtcEngine();
  int _remoteuid = -1;

  // local device
  bool _micmute = false;
  bool _camoff = false;

  // remote device
  bool _rMicmute = false;
  bool _rCamoff = false;

  Future<void> _toggleCam() async {
    await _engine.muteLocalVideoStream(!_camoff);
    setState(() {
      _camoff = !_camoff;
    });
  }

  Future<void> _toggleMic() async {
    await _engine.muteLocalAudioStream(!_micmute);
    setState(() {
      _micmute = !_micmute;
    });
  }

  Future<void> _switchCam() async {
    await _engine.switchCamera();
  }

  Future<void> _endCall() async {}

  Future<void> _setupVideoCall() async {
    await [Permission.microphone, Permission.camera].request();

    await _engine.initialize(const RtcEngineContext(
      appId: "ad0f1717b7c846f7a6fc435c99929ea7",
    ));

    await _engine.enableVideo();

    _engine.registerEventHandler(RtcEngineEventHandler(
      onUserJoined: (connection, remoteUid, elapsed) {
        setState(() {
          _remoteuid = remoteUid;
        });
      },
      onUserMuteAudio: (connection, remoteUid, muted) {
        setState(() {
          _rMicmute = muted;
        });
      },
      onUserMuteVideo: (connection, remoteUid, muted) {
        setState(() {
          _rCamoff = muted;
        });
      },
      onLeaveChannel: (connection, stats) {
        if (mounted) {
          Navigator.of(context).pop();
        }
      },
    ));
  }

  void _answerCall() {}

  void _decline() {}

  void leave() async {
    await _engine.stopPreview();
    await _engine.leaveChannel();
  }

  @override
  void initState() {
    super.initState();
    _setupVideoCall();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _engine.stopPreview();
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _remoteuid == -1 && !widget.caller
            ? VideoCallPicking(answerFn: _answerCall, endCallFn: _decline, call: widget.call)
            : Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: VideoCallView(
                      engine: _engine,
                      channelId: widget.call.callerName,
                      receiverName: widget.call.receiverName,
                      receiverAva: widget.call.receiverCover,
                      localCamoff: _camoff,
                      remoteUid: _remoteuid,
                      remoteMute: _rMicmute,
                      remoteCamoff: _rCamoff,
                      remoteCover: widget.caller ? widget.call.receiverCover : widget.call.callerCover,
                    ),
                  ),
                  // panel
                  Padding(
                    padding: const EdgeInsets.only(bottom: 26),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: VideoCallPanel(
                        mic: !_micmute,
                        cam: !_camoff,
                        toggleMicFn: _toggleMic,
                        toggleCamFn: _toggleCam,
                        switchCamFn: _switchCam,
                        endCallFn: _endCall,
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

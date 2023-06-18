import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/services/navigation_service.dart';
import 'package:permission_handler/permission_handler.dart';

// widgets
import '../widgets/call_picking.dart';
import '../widgets/video_call_view.dart';
import '../widgets/video_call_panel.dart';

class CallScreen extends StatefulWidget {
  final String remotename;
  final String remotecover;
  final String channelId;
  final String token;
  final bool caller;

  const CallScreen({
    super.key,
    required this.token,
    required this.channelId,
    required this.remotename,
    required this.remotecover,
    required this.caller,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final RtcEngine _engine = createAgoraRtcEngine();
  final ReceivePort _port = ReceivePort();
  late Timer timer;
  int _remoteUid = -1;

  // local
  bool _micMute = false;
  bool _camOff = false;

  // remote
  bool _rMicMute = false;
  bool _rCamOff = false;

  Future<void> _toggleCam() async {
    await _engine.muteLocalVideoStream(!_camOff);
    setState(() {
      _camOff = !_camOff;
    });
  }

  Future<void> _toggleMic() async {
    await _engine.muteLocalAudioStream(!_micMute);
    setState(() {
      _micMute = !_micMute;
    });
  }

  Future<void> _swichCam() async {
    await _engine.switchCamera();
  }

  Future<void> _endCall() async {
    if (_remoteUid == -1) {
      AppointmentModel.getById(widget.channelId).then((value) => value.cancelCall());
    }
    _leave();
  }

  Future<void> _setupVideoCall() async {
    await [Permission.microphone, Permission.camera].request();

    // init engine
    await _engine.initialize(const RtcEngineContext(
      appId: "ad0f1717b7c846f7a6fc435c99929ea7",
    ));

    await _engine.enableVideo();

    _engine.registerEventHandler(RtcEngineEventHandler(
      onUserJoined: (connection, remoteUid, elapsed) {
        setState(() {
          _remoteUid = remoteUid;
        });
      },
      onUserMuteAudio: (connection, remoteUid, muted) {
        setState(() {
          _rMicMute = muted;
        });
      },
      onUserMuteVideo: (connection, remoteUid, muted) {
        setState(() {
          _rCamOff = muted;
        });
      },
      onLeaveChannel: (connection, stats) {
        NavigationService.isCalling = false;
        if (mounted) {
          NavigationService.navKey.currentState!.pop();
        }
      },
      onUserOffline: (connection, remoteUid, reason) {
        NavigationService.isCalling = false;
        if (mounted) {
          NavigationService.navKey.currentState!.pop();
        }
      },
      onJoinChannelSuccess: (connection, elapsed) {
        NavigationService.isCalling = true;
      },
    ));

    if (widget.caller) {
      timer = Timer(
        const Duration(seconds: 29),
        () {
          if (_remoteUid == -1) {
            AppointmentModel.getById(widget.channelId).then((value) => value.cancelCall());
            _leave();
          }
        },
      );
    }

    _join();
  }

  void _bindIsolate() {
    IsolateNameServer.registerPortWithName(_port.sendPort, "background_notification_action");
    _port.listen((message) {
      NavigationService.navKey.currentState!.pop();
    });
  }

  void _unbindIsolate() {
    IsolateNameServer.removePortNameMapping("background_notification_action");
  }

  Future<void> _join() async {
    try {
      await _engine.startPreview();

      ChannelMediaOptions options = const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      );

      await _engine.joinChannel(
        token: widget.token,
        channelId: widget.channelId,
        options: options,
        uid: 0,
      );
    } catch (e) {
      return;
    }
  }

  void _leave() async {
    await _engine.stopPreview();
    await _engine.leaveChannel();
  }

  @override
  void initState() {
    super.initState();
    _bindIsolate();
    _setupVideoCall();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    _unbindIsolate();
    if (widget.caller) {
      timer.cancel();
    }
    await _engine.stopPreview();
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _remoteUid == -1 && !widget.caller
            ? Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: const Center(
                  child: Text("Joining..."),
                ),
              )
            : Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: VideoCallView(
                      engine: _engine,
                      remoteUid: _remoteUid,
                      channelId: widget.channelId,
                      remoteName: widget.remotename,
                      remoteCover: widget.remotecover,
                      remoteCamoff: _rCamOff,
                      remoteMute: _rMicMute,
                      localCamoff: _camOff,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 28),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: VideoCallPanel(
                        mic: !_micMute,
                        cam: !_camOff,
                        toggleMicFn: _toggleMic,
                        toggleCamFn: _toggleCam,
                        switchCamFn: _swichCam,
                        endCallFn: _endCall,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

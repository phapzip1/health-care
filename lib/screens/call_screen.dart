import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
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
        if (mounted) {
          NavigationService.navKey.currentState!.pop();
        }
      },
    ));
  }

  Future<void> _join() async {
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
  }

  void _leave() async {
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
        child: _remoteUid == -1 && !widget.caller
            ? CallPicking(
                cover: widget.remotecover,
                name: widget.remotename,
                answerFn: _join,
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

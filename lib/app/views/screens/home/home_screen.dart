import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:calling_app/app/views/widgets/local_video_view_widget.dart';
import 'package:calling_app/app/views/widgets/remote_video_view_widget.dart';
import 'package:calling_app/core/constants/credentials/credential.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RtcEngine? _engine;
  int? _remoteUid;
  bool _localUserJoined = false;
  bool _isEngineInitialized = false;

  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  @override
  void dispose() {
    _disposeAgora();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isEngineInitialized || _engine == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          RemoteVideoView(
            engine: _engine!,
            remoteUid: _remoteUid,
          ),

          Positioned(
            top: 20,
            left: 20,
            child: LocalVideoView(
              engine: _engine!,
              joined: _localUserJoined,
            ),
          ),
        ],
      ),
    );
  }


  Future<void> _initAgora() async {
    // Request permissions
    await [Permission.camera, Permission.microphone].request();

    _engine = createAgoraRtcEngine();
    await _engine!.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));

    await _engine!.enableVideo();
    await _engine!.startPreview();

    _registerEventHandlers();

    await _engine!.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(
        autoSubscribeVideo: true,
        autoSubscribeAudio: true,
        publishCameraTrack: true,
        publishMicrophoneTrack: true,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );

    setState(() {
      _isEngineInitialized = true;
    });
  }

  /// Dispose Agora resources
  Future<void> _disposeAgora() async {
    if (_engine != null) {
      await _engine!.leaveChannel();
      await _engine!.release();
    }
  }


  void _registerEventHandlers() {
    _engine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() => _localUserJoined = true);
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() => _remoteUid = remoteUid);
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          setState(() => _remoteUid = null);
        },
      ),
    );
  }
}



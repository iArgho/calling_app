// agora_service.dart
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
// Remove if possible

class AgoraService {
  RtcEngine? _engine;
  RtcEngine get engine => _engine!;

  Future<void> initialize({
    required String appId,
    required String token,
    required String channelId,
    required int uid,
    required VoidCallback onLocalJoined,
    required ValueChanged<int> onRemoteJoined,
    required VoidCallback onRemoteLeft,
    required ValueChanged<String> onError,
  }) async {
    try {
      // Request permissions
      final status = await _requestPermissions();
      if (!status) {
        onError('Permissions denied');
        return;
      }

      _engine = createAgoraRtcEngine();
      await _engine!.initialize(RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ));

      await _engine!.enableVideo();
      await _engine!.startPreview();

      _engine!.registerEventHandler(RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          onLocalJoined();
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          onRemoteJoined(remoteUid);
        },
        onUserOffline: (connection, remoteUid, reason) {
          onRemoteLeft();
        },
        onError: (err, msg) {
          onError('Agora error: $err - $msg');
        },
        // Add more handlers if needed: onConnectionStateChanged, etc.
      ));

      await _engine!.joinChannel(
        token: token,
        channelId: channelId,
        uid: uid,
        options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          publishCameraTrack: true,
          publishMicrophoneTrack: true,
        ),
      );
    } catch (e) {
      onError('Initialization failed: $e');
    }
  }

  Future<bool> _requestPermissions() async {
    final statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    return statuses[Permission.camera]!.isGranted &&
        statuses[Permission.microphone]!.isGranted;
  }

  Future<void> dispose() async {
    if (_engine == null) return;
    await _engine!.leaveChannel();
    await _engine!.stopPreview();
    await _engine!.release();
    _engine = null;
  }
}
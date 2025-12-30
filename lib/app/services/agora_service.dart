import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:calling_app/core/constants/credentials/credential.dart';
import 'package:permission_handler/permission_handler.dart';

typedef RemoteUidCallback = void Function(int? uid);
typedef LocalJoinCallback = void Function(bool joined);

class AgoraService {
  RtcEngine? _engine;
  final RemoteUidCallback onRemoteUidChanged;
  final LocalJoinCallback onLocalUserJoined;

  AgoraService({required this.onRemoteUidChanged, required this.onLocalUserJoined});

  RtcEngine? get engine => _engine;

  Future<void> initAgora(String channel) async {
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
  }

  void _registerEventHandlers() {
    _engine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          onLocalUserJoined(true);
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          onRemoteUidChanged(remoteUid);
        },
        onUserOffline: (connection, remoteUid, reason) {
          onRemoteUidChanged(null);
        },
      ),
    );
  }

  Future<void> dispose() async {
    if (_engine != null) {
      await _engine!.leaveChannel();
      await _engine!.release();
      _engine = null;
    }
  }
}
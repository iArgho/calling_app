import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/constants/credentials/credential.dart';

class AgoraService {
  late final RtcEngine _engine;
  RtcEngine get engine => _engine;

  Future<RtcEngine> init({
    required void Function() onLocalJoined,
    required void Function(int remoteUid) onRemoteJoined,
    required void Function() onRemoteLeft,
  }) async {
    // Request permissions
    await Permission.camera.request();
    await Permission.microphone.request();

    // Initialize engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(
      const RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    // Register events
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (_, _) => onLocalJoined(),
        onUserJoined: (_, uid, _) => onRemoteJoined(uid),
        onUserOffline: (_, _, _) => onRemoteLeft(),
      ),
    );

    // Enable video and join channel
    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(
        autoSubscribeAudio: true,
        autoSubscribeVideo: true,
        publishCameraTrack: true,
        publishMicrophoneTrack: true,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );

    return _engine;
  }

  /// Leave channel & cleanup
  Future<void> dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }
}
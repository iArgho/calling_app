import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/constants/credentials/credential.dart';

class AgoraService {
  RtcEngine? _engine;

  RtcEngine? get engine => _engine;

  /// Initialize Agora Engine
  Future<RtcEngine> init({
    required void Function() onLocalJoined,
    required void Function(int remoteUid) onRemoteJoined,
    required void Function() onRemoteLeft,
  }) async {
    await _requestPermissions();

    _engine = createAgoraRtcEngine();

    await _engine!.initialize(
      const RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    _registerEvents(
      onLocalJoined: onLocalJoined,
      onRemoteJoined: onRemoteJoined,
      onRemoteLeft: onRemoteLeft,
    );

    await _engine!.enableVideo();
    await _engine!.startPreview();

    await _engine!.joinChannel(
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

    return _engine!;
  }

  /// Leave channel & cleanup
  Future<void> dispose() async {
    if (_engine != null) {
      await _engine!.leaveChannel();
      await _engine!.release();
      _engine = null;
    }
  }

  /// Permissions
  Future<void> _requestPermissions() async {
    await [
      Permission.camera,
      Permission.microphone,
    ].request();
  }

  /// Event handlers
  void _registerEvents({
    required void Function() onLocalJoined,
    required void Function(int remoteUid) onRemoteJoined,
    required void Function() onRemoteLeft,
  }) {
    _engine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (_, __) => onLocalJoined(),
        onUserJoined: (_, uid, __) => onRemoteJoined(uid),
        onUserOffline: (_, __, ___) => onRemoteLeft(),
      ),
    );
  }
}
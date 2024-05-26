import 'package:audio_session/audio_session.dart' as aus;
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teams_voicein/client_service.dart';
import 'package:teams_voicein/recording_button.dart';
import 'package:teams_voicein/wave_widget.dart';

Logger _logger = Logger(level: Level.debug);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ClientService().init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _fileName = 'voice_msg.wav';

  late final FlutterSoundPlayer? _player;
  late final FlutterSoundRecorder? _recorder;

  String _downloads = '';
  bool _isRecording = false;
  bool _playerReady = false;
  bool _recorderReady = false;

  @override
  void initState() {
    _player = FlutterSoundPlayer();
    _recorder = FlutterSoundRecorder();

    _requestDownloadsDirPath();

    openTheRecorder().then((value) {
      setState(() {
        _recorderReady = true;
      });
    });

    _player!.openPlayer().then((value) {
      setState(() {
        _playerReady = true;
      });
    });

    super.initState();
  }

  Future<void> openTheRecorder() async {
    if (!await Permission.microphone.isGranted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    await _recorder!.openRecorder();
    final session = await aus.AudioSession.instance;
    await session.configure(aus.AudioSessionConfiguration(
      avAudioSessionCategory: aus.AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          aus.AVAudioSessionCategoryOptions.allowBluetooth |
              aus.AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: aus.AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          aus.AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: aus.AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const aus.AndroidAudioAttributes(
        contentType: aus.AndroidAudioContentType.speech,
        flags: aus.AndroidAudioFlags.none,
        usage: aus.AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: aus.AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    _recorderReady = true;
  }

  @override
  void dispose() {
    _player!.closePlayer();
    _player = null;
    _recorder!.closeRecorder();
    _recorder = null;
    super.dispose();
  }

  void _requestDownloadsDirPath() async {
    _downloads = (await getDownloadsDirectory())!.path;
  }

  String getFilePath() {
    // return '$_downloads/$_fileName';
    return '/storage/emulated/0/Download/$_fileName';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: const Text('Teams VoiceIn')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_isRecording) const WaveWidget(),
            const SizedBox(height: 18),
            RecordingButton(isRecording: _isRecording, onPressed: record),
            ElevatedButton(
                onPressed: playRecording, child: const Text('Play record')),
            ElevatedButton(
                onPressed: () =>
                    ClientService.instance.recognize(getFilePath()),
                child: const Text('Get Hw'))
          ],
        ),
      ),
    ));
  }

  Future<void> startRecording() async {
    if (!_recorderReady) return;

    try {
      _recorder!.startRecorder(
        audioSource: AudioSource.defaultSource,
        codec: Codec.pcm16WAV,
        toFile: getFilePath(),
        enableVoiceProcessing: true,
        numChannels: 1,
        sampleRate: 16000
      ).then((_) {
        setState(() {});
      });
      _logger.i('Started recording - ${getFilePath()}');
    } catch (e) {
      _logger.e('Error starting recording - ${e.toString()}', error: e);
    }
  }

  Future<void> stopRecording() async {
    try {
      await _recorder!.stopRecorder().then((value) {
        _logger.i('Stopped recording - $value');
        setState(() {});
      });
    } catch (e) {
      _logger.e('Error stopping recording - ${e.toString()}', error: e);
    }
  }

  void record() async {
    if (_isRecording) {
      await stopRecording();
    } else {
      await startRecording();
    }
    setState(() {
      _isRecording = !_isRecording;
    });
  }

  Future<void> playRecording() async {
    if (!_playerReady) return;

    try {
      _player!.startPlayer(
          fromURI: getFilePath(),
          whenFinished: () {
            setState(() {});
          });
    } catch (e) {
      _logger.e('Error playing recording - ${e.toString()}', error: e);
    }
  }
}

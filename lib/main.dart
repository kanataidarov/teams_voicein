import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:teams_voicein/recording_button.dart';
import 'package:teams_voicein/wave_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _fileName = 'voice_msg.wav';

  late final AudioPlayer _player;
  late final AudioRecorder _recorder;

  String _downloads = '';
  bool _isRecording = false;

  @override
  void initState() {
    _player = AudioPlayer();
    _recorder = AudioRecorder();
    _requestDownloadsDirPath();
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    _recorder.dispose();
    super.dispose();
  }

  void _requestDownloadsDirPath() async {
    _downloads = (await getDownloadsDirectory())!.path;
  }

  String getFilePath() {
    return '$_downloads/$_fileName';
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
            // ElevatedButton(onPressed: playRecording, child: Text('Play record'))
          ],
        ),
      ),
    ));
  }

  Future<void> startRecording() async {
    try {
      if (await _recorder.hasPermission()) {
        print('TVI__: Started recording - ${getFilePath()}');
        await _recorder.start(const RecordConfig(encoder: AudioEncoder.wav),
            path: getFilePath());
      }
    } catch (e) {
      print('TVI__: Error starting recording - $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await _recorder.stop();
      print('TVI__: Stopped recording - $path');
    } catch (e) {
      print('TVI__: Error stopping recording - $e');
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
    try {
      Source url = UrlSource(getFilePath());
      await _player.play(url);
    } catch (e) {
      print('TVI__: Error playing recording - $e');
    }
  }
}

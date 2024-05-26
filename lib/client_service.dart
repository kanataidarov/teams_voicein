import 'dart:io';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:teams_voicein/service/teams_voicein/stt.pbgrpc.dart';

Logger _logger = Logger(level: Level.debug);

class ClientService {
  final String baseUrl = '192.168.8.10';

  ClientService._internal();
  static final ClientService _instance = ClientService._internal();

  factory ClientService() => _instance;

  static ClientService get instance => _instance;

  late SpeechToTextClient _client;

  Future<void> init() async {
    _createChannel();
  }

  SpeechToTextClient get getClient {
    return _client;
  }

  _createChannel() {
    final channel = ClientChannel(baseUrl,
        port: 44044,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));
    _client = SpeechToTextClient(channel);
  }

  Future<void> recognize(final filePath) async {
    try {
      var file = File(filePath);

      FileHeader header = FileHeader(name: filePath, size: Int64(file.lengthSync()));
      SttRequest request = SttRequest(header: header, data: file.readAsBytesSync());

      var response = await _client.recognize(request);
      _logger.i('Response - ${response.message}');
    } on GrpcError catch (e) {
      _logger.e('Error sending SttRequest - ${e.message}', error: e);
    } catch (e) {
      _logger.e('Unexpected error - ${e.toString()}', error: e);
    }
  }
}

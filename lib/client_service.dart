import 'dart:io';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:teams_voicein/service/teams_voicein/stt.pbgrpc.dart';

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
      print('TVI__: Response - ${response.message}');
    } on GrpcError catch (e) {
      print('TVI__: Error sending HwRequest - $e');
    } catch (e) {
      print('TVI__: Unexpected error - $e');
    }
  }
}

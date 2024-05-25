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
    final channel = ClientChannel(baseUrl, port: 44044, options: const ChannelOptions(credentials: ChannelCredentials.insecure()));
    _client = SpeechToTextClient(channel);
  }
}
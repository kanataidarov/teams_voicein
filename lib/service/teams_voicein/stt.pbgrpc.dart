//
//  Generated code. Do not modify.
//  source: teams_voicein/stt.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'stt.pb.dart' as $0;

export 'stt.pb.dart';

@$pb.GrpcServiceName('teams_voicein.SpeechToText')
class SpeechToTextClient extends $grpc.Client {
  static final _$sayHello = $grpc.ClientMethod<$0.HwRequest, $0.HwResponse>(
      '/teams_voicein.SpeechToText/SayHello',
      ($0.HwRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HwResponse.fromBuffer(value));

  SpeechToTextClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.HwResponse> sayHello($0.HwRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sayHello, request, options: options);
  }
}

@$pb.GrpcServiceName('teams_voicein.SpeechToText')
abstract class SpeechToTextServiceBase extends $grpc.Service {
  $core.String get $name => 'teams_voicein.SpeechToText';

  SpeechToTextServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.HwRequest, $0.HwResponse>(
        'SayHello',
        sayHello_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HwRequest.fromBuffer(value),
        ($0.HwResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.HwResponse> sayHello_Pre($grpc.ServiceCall call, $async.Future<$0.HwRequest> request) async {
    return sayHello(call, await request);
  }

  $async.Future<$0.HwResponse> sayHello($grpc.ServiceCall call, $0.HwRequest request);
}

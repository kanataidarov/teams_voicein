//
//  Generated code. Do not modify.
//  source: teams_voicein/stt.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class HwRequest extends $pb.GeneratedMessage {
  factory HwRequest() => create();
  HwRequest._() : super();
  factory HwRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HwRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HwRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'teams_voicein'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HwRequest clone() => HwRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HwRequest copyWith(void Function(HwRequest) updates) => super.copyWith((message) => updates(message as HwRequest)) as HwRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HwRequest create() => HwRequest._();
  HwRequest createEmptyInstance() => create();
  static $pb.PbList<HwRequest> createRepeated() => $pb.PbList<HwRequest>();
  @$core.pragma('dart2js:noInline')
  static HwRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HwRequest>(create);
  static HwRequest? _defaultInstance;
}

class HwResponse extends $pb.GeneratedMessage {
  factory HwResponse({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  HwResponse._() : super();
  factory HwResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HwResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HwResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'teams_voicein'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HwResponse clone() => HwResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HwResponse copyWith(void Function(HwResponse) updates) => super.copyWith((message) => updates(message as HwResponse)) as HwResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HwResponse create() => HwResponse._();
  HwResponse createEmptyInstance() => create();
  static $pb.PbList<HwResponse> createRepeated() => $pb.PbList<HwResponse>();
  @$core.pragma('dart2js:noInline')
  static HwResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HwResponse>(create);
  static HwResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');

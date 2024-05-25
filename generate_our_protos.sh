#! /usr/bin/env bash

set -e

PROTOC_OPTS="-I./apis/ --dart_out=grpc:lib/service/"

rm -rf lib/service/
mkdir lib/service/

protoc $PROTOC_OPTS ./apis/teams_voicein/*.proto
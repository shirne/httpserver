import 'dart:developer';

import 'package:logging/logging.dart';

import 'env.dart';

const keyToken = 'token';
const keyIsLogin = 'is_login';

const errorNeedLogin = 99;
const errorLoginFailed = 101;
const errorNeedVerify = 104;
const errorNeedRegister = 109;
const errorRegisterFailed = 111;
const errorTokenInvaild = 102;
const errorTokenExpire = 103;
const errorRefreshTokenInvaild = 105;
const errorTmpTokenInvaild = 115;
const errorNeedOpenid = 112;
const errorMemberDisabled = 113;

typedef Json = Map<String, dynamic>;

typedef DataParser<T> = T? Function(Json);

final logger = Logger.root
  ..level = Env.instance.isDebug ? Level.WARNING : Level.ALL
  ..onRecord.listen((record) {
    log(
      record.message,
      time: record.time,
      level: record.level.value,
      error: record.error,
      stackTrace: record.stackTrace,
      sequenceNumber: record.sequenceNumber,
    );
  });

StackTrace? castStackTrace(StackTrace? trace, [int lines = 3]) {
  if (trace != null) {
    return StackTrace.fromString(
      trace.toString().split('\n').sublist(0, lines).join('\n'),
    );
  }
  return null;
}

extension StackTraceExt on StackTrace {
  StackTrace cast(int lines) {
    return castStackTrace(this, lines)!;
  }
}

extension StringNullExt on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

extension ListNullExt<E> on List<E>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

extension MapNullExt<K, E> on Map<K, E>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

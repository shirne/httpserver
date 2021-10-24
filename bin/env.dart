import 'dart:io';

import 'package:ini/ini.dart';

class Env {
  final String port;
  final String ip;
  final String domain;
  final List<String> alias;
  final bool isSSL;

  Env.file(String file)
      : port = getItem(file, 'PORT') ?? '8080',
        ip = getItem(file, 'IP') ?? '',
        domain = getItem(file, 'DOMAIN') ?? '',
        alias = (getItem(file, 'ALIAS') ?? '').split(' '),
        isSSL = getItem(file, 'IS_SSL') == '1';

  Env() : this.file('.env');

  static Config? _parsed;
  static Config parse(String file) {
    if (_parsed == null) {
      final lines = File(file).readAsLinesSync();
      _parsed = Config.fromStrings(lines);
    }
    return _parsed!;
  }

  static String? getItem(String file, String name) {
    return parse(file).get('default', name);
  }

  Map<String, dynamic> toJson() {
    return {
      'PORT': port,
      'IP': ip,
      'DOMAIN': domain,
      'ALIAS': alias,
      'IS_SSL': isSSL,
    };
  }

  @override
  String toString() => toJson().toString();
}

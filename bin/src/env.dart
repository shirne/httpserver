import 'dart:io';

import 'package:ini/ini.dart';

class Env {
  final String port;
  final String ip;
  final String domain;
  final String documentRoot;
  final List<String> alias;
  final bool isSSL;
  final String hostName;
  final String database;
  final String userName;
  final String password;

  Env.file(String file)
      : port = getItem(file, 'PORT') ?? '8080',
        ip = getItem(file, 'IP') ?? '',
        domain = getItem(file, 'DOMAIN') ?? '',
        documentRoot = getItem(file, 'ROOT') ?? '',
        alias = (getItem(file, 'ALIAS') ?? '').split(' '),
        isSSL = getItem(file, 'IS_SSL') == '1',
        hostName = getItem(file, 'HOSTNAME', 'DATABASE') ?? '',
        database = getItem(file, 'DATABASE', 'DATABASE') ?? '',
        userName = getItem(file, 'USERNAME', 'DATABASE') ?? '',
        password = getItem(file, 'PASSWORD', 'DATABASE') ?? '';

  Env() : this.file('.env');

  static Config? _parsed;
  static Config parse(String file) {
    if (_parsed == null) {
      final lines = File(file).readAsLinesSync();
      _parsed = Config.fromStrings(lines);
    }
    return _parsed!;
  }

  static String? getItem(String file, String option,
      [String name = 'default']) {
    return parse(file).get(name, option);
  }

  Map<String, dynamic> toJson() => {
        'PORT': port,
        'IP': ip,
        'DOMAIN': domain,
        'ALIAS': alias,
        'IS_SSL': isSSL,
        'HOSTNAME': hostName,
        'DATABASE': database,
        'USERNAME': userName,
        'PASSWORD': password,
      };

  @override
  String toString() => toJson().toString();
}

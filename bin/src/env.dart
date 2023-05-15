import 'dart:io';

import 'package:ini/ini.dart';

import 'globals.dart';

enum EnvSource {
  file,
  environment,
}

class Env {
  Env.init({
    this.port = '8080',
    this.ip = '',
    this.domain = '',
    this.documentRoot = '',
    this.alias = const <String>[],
    this.isSSL = false,
    this.type = 'mysql',
    this.hostName = '',
    this.dataport = 3306,
    this.database = '',
    this.userName = '',
    this.password = '',
  });

  Env.config(Config? config)
      : this.init(
          port: config?.get('default', 'PORT') ?? '8080',
          ip: config?.get('default', 'IP') ?? '',
          domain: config?.get('default', 'DOMAIN') ?? '',
          documentRoot: config?.get('default', 'ROOT') ?? '',
          alias: (config?.get('default', 'ALIAS') ?? '').split(' '),
          isSSL: config?.get('default', 'IS_SSL') == '1',
          type: config?.get('DATABASE', 'TYPE') ?? 'mysql',
          hostName: config?.get('DATABASE', 'HOSTNAME') ?? '',
          dataport:
              int.parse(config?.get('DATABASE', 'DATABASE_PORT') ?? '3306'),
          database: config?.get('DATABASE', 'DATABASE') ?? '',
          userName: config?.get('DATABASE', 'USERNAME') ?? '',
          password: config?.get('DATABASE', 'PASSWORD') ?? '',
        );

  Env.file(String file)
      : this.config(Config.fromStrings(File(file).readAsLinesSync()));

  Env.json(Json env)
      : this.init(
          port: env['PORT'] ?? '8080',
          ip: env['IP'] ?? '',
          domain: env['DOMAIN'] ?? '',
          documentRoot: env['ROOT'] ?? '',
          alias: (env['ALIAS'] ?? '').split(' '),
          isSSL: env['IS_SSL'] == '1',
          type: env['DATABASE']?['TYPE'] ?? 'mysql',
          hostName: env['DATABASE']?['HOSTNAME'] ?? '',
          dataport: int.parse(env['DATABASE']?['DATABASE_PORT'] ?? '3306'),
          database: env['DATABASE']?['DATABASE'] ?? '',
          userName: env['DATABASE']?['USERNAME'] ?? '',
          password: env['DATABASE']?['PASSWORD'] ?? '',
        );

  Env.environment() : this.json(Platform.environment);

  factory Env([EnvSource src = EnvSource.file, String? path]) {
    switch (src) {
      case EnvSource.file:
        _instance ??= Env.file(path ?? '.env');
        break;
      case EnvSource.environment:
        _instance ??= Env.environment();
        break;
    }

    return _instance!;
  }

  static Env? _instance;

  final String port;
  final String ip;
  final String domain;
  final String documentRoot;
  final List<String> alias;
  final bool isSSL;

  final String type;
  final String hostName;
  final int dataport;
  final String database;
  final String userName;
  final String password;

  Env copyWith(Json args) {
    return Env.init(
      port: args['port'] ?? port,
      ip: args['ip'] ?? ip,
      domain: args['domain'] ?? domain,
      documentRoot: args['root'] ?? documentRoot,
      alias: args['alias'] ?? alias,
      isSSL: args['ssl'] ?? args['no-ssl'] ?? isSSL,
      type: args['type'] ?? type,
      hostName: args['hostname'] ?? hostName,
      dataport: args['dataport'] ?? dataport,
      database: args['database-name'] ?? database,
      userName: args['username'] ?? userName,
      password: args['password'] ?? password,
    );
  }

  Map<String, dynamic> toJson() => {
        'PORT': port,
        'IP': ip,
        'DOMAIN': domain,
        'ALIAS': alias,
        'IS_SSL': isSSL,
        'TYPE': type,
        'HOSTNAME': hostName,
        'DATABASE': database,
        'USERNAME': userName,
        'PASSWORD': password,
      };

  @override
  String toString() => toJson().toString();
}

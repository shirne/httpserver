import 'dart:io';

import 'package:args/args.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_static/shelf_static.dart';

import 'src/core/middleware.dart';
import 'src/env.dart';
import 'src/service.dart';
import 'src/socket.dart';

void main(List<String> args) async {
  final parser = ArgParser()
    ..addFlag('help', abbr: 'h', negatable: false, help: 'print this helps')
    ..addOption(
      'mode',
      abbr: 'm',
      help: 'env mode,fetch env from a file or environment',
    )
    ..addOption('file', help: 'config file path. defaults ./.env')
    ..addSeparator('server options')
    ..addOption('ip', help: 'bind ip address. defaults 0.0.0.0')
    ..addOption('port', help: 'bind port. defaults 8080')
    ..addOption('domain', help: 'bind domain.')
    ..addOption('root', help: 'static file root. defaults ./htdocs')
    ..addMultiOption('alias', help: 'alia domains.')
    ..addFlag('ssl', help: 'use ssl or not.')
    ..addSeparator('database options')
    ..addOption('database-type', help: 'database type. defaults mysql')
    ..addOption('hostname', help: 'database hostname.')
    ..addOption('dataport', help: 'database port')
    ..addOption('database-name', help: 'database name to connect.')
    ..addOption('username', help: 'database username.')
    ..addOption('password', help: 'database password');

  final arguments = parser.parse(args);
  if (arguments.wasParsed('help')) {
    print(parser.usage);
    return;
  }

  final env = Env(
    arguments['mode'] == EnvSource.environment.name
        ? EnvSource.environment
        : EnvSource.file,
    arguments['file'],
  ).copyWith(<String, dynamic>{
    for (var name in arguments.options) name: arguments[name],
  });

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.tryParse(env.ip) ?? InternetAddress.anyIPv4;

  final application = Pipeline()
      .addMiddleware(authMiddleware)
      .addMiddleware(logRequests())
      .addHandler(Service().handler);

  final staticFileHandler = createStaticHandler(
    env.documentRoot,
    defaultDocument: 'index.html',
  );

  // Configure a pipeline that logs requests.
  final handler = Cascade()
      .add(webSocketHandler)
      .add(staticFileHandler)
      .add(application)
      .handler;

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(env.port);
  final server = await serve(handler, ip, port);

  server.autoCompress = true;

  print('Server listening on port ${ip.address}:${server.port} \n'
      'with document root ${env.documentRoot}');
}

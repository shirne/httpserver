import 'dart:io' as io;

import 'package:http/http.dart';
import 'package:test/test.dart';

import '../bin/src/env.dart';

void main() {
  final env = Env();
  final port = env.port;
  final host = 'http://127.0.0.1:$port';
  late io.Process p;

  setUp(() async {
    p = await io.Process.start(
      'dart',
      ['run', 'bin/server.dart'],
    );
    print('server started in process: ${p.pid}');

    // Wait for server to start and print to stdout.
    await p.stdout.first;
  });

  tearDown(() => p.kill());

  test('Root', () async {
    final response = await get(Uri.parse('$host/'));
    expect(response.statusCode, 200);
    expect(response.body, '{"code":0,"message":"ok","data":"index"}');
  });

  test('Echo', () async {
    final response = await get(Uri.parse('$host/echo/hello'));
    expect(response.statusCode, 200);
    expect(response.body, 'hello\n');
  });
  test('404', () async {
    final response = await get(Uri.parse('$host/foobar'));
    expect(response.statusCode, 404);
  });

  test('websocket', () async {
    final webSocket = await io.WebSocket.connect(
      host.replaceFirst('http:', 'ws:'),
    );
    print(webSocket.readyState);
    webSocket.listen(
      (event) {
        print(event);
      },
      onDone: () => print('closed'),
      onError: (e) {
        print('error:$e');
      },
    );

    webSocket.add('put data');
    await webSocket.close();
  });
}

import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:test_process/test_process.dart';

import 'dart:io' as io;

void main() {
  final port = '8080';
  final host = 'http://0.0.0.0:$port';

  setUp(() async {
    // await TestProcess.start(
    //   'dart',
    //   ['run', 'bin/server.dart'],
    //   environment: {'PORT': port},
    // );
  });

  test('Root', () async {
    final response = await get(Uri.parse(host + '/'));
    expect(response.statusCode, 200);
    expect(response.body, '{"code":0,"message":"ok","data":"index"}');
  });

  test('Echo', () async {
    final response = await get(Uri.parse(host + '/echo/hello'));
    expect(response.statusCode, 200);
    expect(response.body, 'hello\n');
  });
  test('404', () async {
    final response = await get(Uri.parse(host + '/foobar'));
    expect(response.statusCode, 404);
  });

  test('websocket', () async {
    io.WebSocket webSocket = await io.WebSocket.connect('ws://127.0.0.1:8080');
    print(webSocket.readyState);
    webSocket.listen(
        (event) {
          print(event);
        },
        onDone: () => print('closed'),
        onError: (e) {
          print('error:$e');
        });

    webSocket.add('put data');
    await webSocket.close();
  });
}

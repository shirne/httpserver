import 'package:shelf_web_socket/shelf_web_socket.dart' as web_socket;

final webSocketHandler = web_socket.webSocketHandler((webSocket) {
  webSocket.stream.listen((message) {
    print('echo $message');
    webSocket.sink.add('echo $message');
  });
});

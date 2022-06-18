import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

import 'src/controller/index.dart';
import 'src/controller/post.dart';
import 'src/core/middleware.dart';
import 'src/env.dart';

// Configure routes.
final _router = Router(notFoundHandler: _notFoundHandler)
  ..all('/post/<action>', (request) => PostController(request).handler())
  ..get('/', (request) => IndexController(request).handler())
  ..get('/echo/<message>', _echoHandler);

Response _notFoundHandler(Request req) {
  return Response.notFound('${req.url} not found!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

void main(List<String> args) async {
  final env = Env();
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.tryParse(env.ip) ?? InternetAddress.anyIPv4;

  final application = Pipeline()
      .addMiddleware(authMiddleware)
      .addMiddleware(logRequests())
      .addHandler(_router);

  final staticFileHandler = createStaticHandler(
    env.documentRoot,
    defaultDocument: 'index.html',
  );

  // Configure a pipeline that logs requests.
  final _handler = Cascade()
      //.add(webSocketHandler)
      .add(staticFileHandler)
      .add(application)
      .handler;

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(env.port);
  final server = await serve(_handler, ip, port);
  print('Server listening on port ${ip.address}:${server.port} '
      'with document root ${env.documentRoot}');
}

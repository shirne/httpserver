import 'package:shelf/shelf.dart';

Handler authMiddleware(Handler innerHandler) {
  return (Request request) {
    final token = request.headers['token'] ?? '';

    // TODO 验证

    return innerHandler(request);
  };
}

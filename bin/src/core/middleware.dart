import 'package:shelf/shelf.dart';

import '../globals.dart';
import '../module/token.dart';
import 'result.dart';

Handler authMiddleware(Handler innerHandler) {
  return (Request request) async {
    final token = request.headers['token'] ?? '';

    if (token.isNotEmpty) {
      final tokenModel = await TokenModule().find(token);
      if (tokenModel != null) {
        if (tokenModel.expireIn + tokenModel.updateTime <
            DateTime.now().millisecondsSinceEpoch / 1000) {
          return Response.forbidden(Result.error('Token expired'));
        }
        request.context[keyIsLogin] = true;

        request.context[keyToken] = TokenModule().find(token);
      } else {
        return Response.forbidden(Result.error('Invalid token'));
      }
    }

    request.context.putIfAbsent(keyIsLogin, () => false);

    return innerHandler(request);
  };
}

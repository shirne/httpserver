import 'package:shelf/shelf.dart';

import '../globals.dart';
import '../module/token.dart';
import 'result.dart';

Handler authMiddleware(Handler innerHandler) {
  return (Request request) async {
    final token = request.headers['token'] ?? '';

    final newContext = <String, dynamic>{};
    if (token.isNotEmpty) {
      final tokenModel = await TokenModule().find(token);
      if (tokenModel != null) {
        if (tokenModel.expireIn + tokenModel.updateTime <
            DateTime.now().millisecondsSinceEpoch / 1000) {
          return Response.forbidden(Result.error('Token expired'));
        }
        newContext[keyIsLogin] = true;

        newContext[keyToken] = TokenModule().find(token);
      } else {
        return Response.forbidden(Result.error('Invalid token'));
      }
    }

    newContext.putIfAbsent(keyIsLogin, () => false);

    return innerHandler(request.change(context: newContext));
  };
}

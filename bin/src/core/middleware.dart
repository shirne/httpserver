import 'package:shelf/shelf.dart';

import '../globals.dart';
import '../module/token.dart';
import 'result.dart';

Handler authMiddleware(Handler innerHandler) {
  return (Request request) async {
    final token = request.headers['token'] ?? '';

    final newContext = <String, dynamic>{
      keyIsLogin: false,
    };
    if (token.isNotEmpty) {
      final tokenModel = await TokenModule().find(token);
      if (tokenModel != null) {
        if (tokenModel.expireIn + tokenModel.updateTime <
            DateTime.now().millisecondsSinceEpoch / 1000) {
          return Response.forbidden(
            Result.error('Token expired', code: errorTokenExpire),
          );
        }
        newContext[keyIsLogin] = true;

        newContext[keyToken] = tokenModel;
      } else {
        return Response.forbidden(
          Result.error('Invalid token', code: errorTokenInvaild),
        );
      }
    }

    return innerHandler(request.change(context: newContext));
  };
}

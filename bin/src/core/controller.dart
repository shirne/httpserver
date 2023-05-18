import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../globals.dart';
import 'result.dart';

abstract class Controller {
  bool get needLogin => false;

  Router get router;

  Future<Response?> init(Request request, RouterEntry route) async {
    if (needLogin) {
      if (request.context[keyIsLogin] != true) {
        return Response.forbidden(
          Result.error('Need Login', code: errorNeedLogin),
        );
      }
    }
    return null;
  }

  Response error(Result result) {
    return Response.internalServerError(body: result.toString());
  }

  Response response(Result result) {
    return Response.ok(result.toString());
  }
}

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'result.dart';

abstract class Controller {
  bool get needLogin => false;

  Router get router;

  Response response(Result result){
    return Response.ok(result.toString());
  }
}

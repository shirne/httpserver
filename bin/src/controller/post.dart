import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../core/controller.dart';
import '../core/result.dart';

class PostController extends Controller {
  PostController(Request request) : super(request);

  FutureOr<Response> handler() async {
    print(request.params['action']);
    return Response.ok(index().toString());
  }

  Result<String> index() {
    return Result(data: 'post index');
  }
}

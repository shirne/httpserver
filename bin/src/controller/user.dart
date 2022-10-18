import 'dart:async';

import 'package:shelf/shelf.dart';

import '../core/controller.dart';
import '../core/result.dart';

class UserController extends Controller {
  UserController(Request request) : super(request);

  FutureOr<Response> handler() async {
    return Response.ok(index().toString());
  }

  Result<String> index() {
    return Result(data: 'index');
  }
}

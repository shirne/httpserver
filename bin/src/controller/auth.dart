import 'dart:async';

import 'package:shelf/shelf.dart';

import '../core/controller.dart';
import '../core/result.dart';

class AuthController extends Controller {
  AuthController(Request request) : super(request);

  FutureOr<Response> handler() async {
    if (request.url.pathSegments.isNotEmpty) {
      switch (request.url.pathSegments[0]) {
        case 'login':
          return Response.ok(login().toString());
      }
    }
    return Response.ok(index().toString());
  }

  Result<String> index() {
    return Result(data: 'index');
  }

  Result<String> login() {
    return Result(data: 'profile');
  }
}

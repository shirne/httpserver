import 'dart:async';

import 'package:shelf/shelf.dart';

import '../core/controller.dart';
import '../core/result.dart';

class UserController extends Controller {
  UserController(Request request) : super(request);

  FutureOr<Response> handler() async {
    if (request.url.pathSegments.isNotEmpty) {
      switch (request.url.pathSegments[0]) {
        case 'profile':
          return Response.ok(profile().toString());
      }
    }
    return Response.ok(index().toString());
  }

  Result<String> index() {
    return Result(data: 'index');
  }

  Result<String> profile() {
    return Result(data: 'profile');
  }
}

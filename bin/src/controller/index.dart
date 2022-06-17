import 'dart:async';

import 'package:shelf/shelf.dart';

import '../core/controller.dart';
import '../core/result.dart';

class IndexController extends Controller {
  IndexController(Request request) : super(request);

  FutureOr<Response> handler() async {
    return Response.ok(index().toString());
  }

  Result<String> index() {
    return Result(data: 'index');
  }
}

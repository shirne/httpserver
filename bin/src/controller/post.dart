import 'dart:async';

import 'package:shelf/shelf.dart';

import '../core/controller.dart';
import '../core/result.dart';

class PostController extends Controller {
  PostController(Request request) : super(request);

  FutureOr<Response> handler() async {
    if (request.url.pathSegments.isNotEmpty) {
      switch (request.url.pathSegments[0]) {
        case 'list':
          return Response.ok(list().toString());
        case 'view':
          return Response.ok(view().toString());
      }
    }
    return Response.ok(index().toString());
  }

  Result<String> index() {
    return Result(data: 'post index');
  }

  Result<String> list() {
    return Result(data: 'post list');
  }

  Result<String> view() {
    if (request.url.pathSegments.length < 2) {
      return Result.error('Argument error');
    }
    final id = int.tryParse(request.url.pathSegments[1]) ?? 0;
    if (id <= 0) {
      return Result.error('Argument error');
    }
    return Result(data: 'post view $id');
  }
}

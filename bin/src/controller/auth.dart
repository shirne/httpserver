import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../core/controller.dart';
import '../core/result.dart';

part 'auth.g.dart';

class AuthController extends Controller {
  AuthController() : super();

  @Route.post('/index')
  FutureOr<Response> _index(Request request) {
    return response(Result(data: 'index'));
  }

  @Route.post('/login')
  FutureOr<Response> _login(Request request) {
    return response(Result(data: 'login'));
  }

  @Route.all('/<ignored|.*>')
  Response _notFound(Request request) => Response.notFound('null');

  @override
  Router get router => _$AuthControllerRouter(this);
}

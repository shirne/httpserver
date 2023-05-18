import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/controller.dart';
import '../../core/result.dart';

part 'auth.g.dart';

class AuthController extends Controller {
  AuthController() : super();

  @override
  bool get needLogin => false;

  @Route.get('/index')
  FutureOr<Response> _index(Request request) {
    return response(Result(data: 'index'));
  }

  @Route.get('/captcha')
  FutureOr<Response> _captcha(Request request) {
    return response(Result(data: 'index'));
  }

  @Route.post('/login')
  FutureOr<Response> _login(Request request) {
    return response(Result(data: 'login'));
  }

  @Route.post('/refresh')
  FutureOr<Response> _refresh(Request request) {
    return response(Result(data: 'refresh'));
  }

  @override
  Router get router => _$AuthControllerRouter(this);
}

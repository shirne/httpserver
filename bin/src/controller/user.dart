import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../core/controller.dart';
import '../core/result.dart';

part 'user.g.dart';

class UserController extends Controller {
  UserController() : super();

  @override
  bool get needLogin => true;

  @Route.get('/index')
  FutureOr<Response> _index(Request request) {
    return response(Result(data: 'index'));
  }

  @Route.get('/profile')
  FutureOr<Response> _profile(Request request) {
    return response(Result(data: 'profile'));
  }

  @Route.all('/<ignored|.*>')
  Response _notFound(Request request) => Response.notFound('null');

  @override
  Router get router => _$UserControllerRouter(this);
}

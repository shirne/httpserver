import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/controller.dart';
import '../../core/result.dart';

part 'user.g.dart';

class UserController extends Controller {
  UserController() : super();

  @override
  bool get needLogin => true;

  @Route.get('/index')
  FutureOr<Response> _index(Request request) {
    return response(Result(data: 'index'));
  }

  @Route.get('/detail/<id|\\d+>')
  FutureOr<Response> _detail(Request request, String id) {
    final intId = int.parse(id);
    if (intId <= 0) {
      return response(Result.error('Argument error'));
    }
    return response(Result(data: 'detail $id'));
  }

  @Route.post('/create')
  FutureOr<Response> _create(Request request) {
    return response(Result(data: 'update'));
  }

  @Route.post('/update/<id|\\d+>')
  FutureOr<Response> _update(Request request, String id) {
    final intId = int.parse(id);
    if (intId <= 0) {
      return response(Result.error('Argument error'));
    }
    return response(Result(data: 'update $id'));
  }

  @override
  Router get router => _$UserControllerRouter(this);
}

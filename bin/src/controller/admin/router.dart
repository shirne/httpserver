import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/group.dart';
import 'auth.dart';
import 'post.dart';
import 'user.dart';
import 'admin.dart';

part 'router.g.dart';

class AdminRouter extends Group {
  @Route.mount('/auth/')
  Router get _auth => AuthController().router;

  @Route.mount('/post/')
  Router get _post => PostController().router;

  @Route.mount('/user/')
  Router get _user => UserController().router;

  @Route.mount('/admin/')
  Router get _admin => AdminController().router;

  @Route.all('/<ignored|.*>')
  Response _notFound(Request request) => Response.notFound('Page not found');

  Router get router => _$AdminRouterRouter(this);
}

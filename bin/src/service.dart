import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'controller/auth.dart';
import 'controller/post.dart';
import 'controller/user.dart';

part 'service.g.dart';

class Service {
  @Route.get('/echo/<message>')
  Response _echo(Request request, String message) => Response.ok(message);

  @Route.mount('/auth/')
  Router get _auth => AuthController().router;

  @Route.mount('/post/')
  Router get _post => PostController().router;

  @Route.mount('/user/')
  Router get _user => UserController().router;

  @Route.all('/<ignored|.*>')
  Response _notFound(Request request) => Response.notFound('Page not found');

  Handler get handler => _$ServiceRouter(this);
}

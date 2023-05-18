// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$UserControllerRouter(UserController service) {
  final router = Router(routeHandler: service.init);
  router.add(
    'GET',
    r'/index',
    service._index,
  );
  router.add(
    'GET',
    r'/detail/<id|\d+>',
    service._detail,
  );
  router.add(
    'POST',
    r'/create',
    service._create,
  );
  router.add(
    'POST',
    r'/update/<id|\d+>',
    service._update,
  );
  return router;
}

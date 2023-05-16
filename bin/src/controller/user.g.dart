// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$UserControllerRouter(UserController service) {
  final router = Router();
  router.add(
    'GET',
    r'/index',
    service._index,
  );
  router.add(
    'GET',
    r'/profile',
    service._profile,
  );
  router.all(
    r'/<ignored|.*>',
    service._notFound,
  );
  return router;
}

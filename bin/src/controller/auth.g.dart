// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$AuthControllerRouter(AuthController service) {
  final router = Router();
  router.add(
    'POST',
    r'/index',
    service._index,
  );
  router.add(
    'POST',
    r'/login',
    service._login,
  );
  router.all(
    r'/<ignored|.*>',
    service._notFound,
  );
  return router;
}

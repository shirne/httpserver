// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$AuthControllerRouter(AuthController service) {
  final router = Router(routeHandler: service.init);
  router.add(
    'GET',
    r'/index',
    service._index,
  );
  router.add(
    'GET',
    r'/captcha',
    service._captcha,
  );
  router.add(
    'POST',
    r'/login',
    service._login,
  );
  router.add(
    'POST',
    r'/refresh',
    service._refresh,
  );
  return router;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$ServiceRouter(Service service) {
  final router = Router(routeHandler: service.init);
  router.add(
    'GET',
    r'/echo/<message>',
    service._echo,
  );
  router.mount(
    r'/auth/',
    service._auth,
  );
  router.mount(
    r'/post/',
    service._post,
  );
  router.mount(
    r'/user/',
    service._user,
  );
  router.mount(
    r'/admin/',
    service._admin,
  );
  router.all(
    r'/<ignored|.*>',
    service._notFound,
  );
  return router;
}

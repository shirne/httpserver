// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$AdminRouterRouter(AdminRouter service) {
  final router = Router(routeHandler: service.init);
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

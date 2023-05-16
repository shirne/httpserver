// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$PostControllerRouter(PostController service) {
  final router = Router();
  router.add(
    'GET',
    r'/index',
    service._index,
  );
  router.add(
    'GET',
    r'/list',
    service._list,
  );
  router.add(
    'GET',
    r'/view/<id|\d+>',
    service._view,
  );
  router.add(
    'GET',
    r'/category',
    service._category,
  );
  router.all(
    r'/<ignored|.*>',
    service._notFound,
  );
  return router;
}

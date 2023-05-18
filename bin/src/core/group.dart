import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

abstract class Group {
  Future<Response?> init(Request request, RouterEntry route) async {
    return null;
  }
}

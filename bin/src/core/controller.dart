import 'package:shelf/shelf.dart';

abstract class Controller {
  final Request request;

  bool get needLogin => false;

  Controller(this.request);
}

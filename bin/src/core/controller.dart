import 'package:shelf/shelf.dart';

abstract class Controller {
  final Request request;
  Controller(this.request);
}

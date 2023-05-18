import 'controller.dart';

abstract class AdminController extends Controller {
  @override
  bool get needLogin => true;
}

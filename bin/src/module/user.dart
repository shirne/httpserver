import '../core/module.dart';
import '../globals.dart';
import '../model/user.dart';

class UserModule extends Module<User, int> {
  @override
  User parser(Json json) => User.fromJson(json);

  @override
  String get primary => 'id';

  @override
  String get table => 'member';
}

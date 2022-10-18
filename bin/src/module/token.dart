import '../core/module.dart';
import '../globals.dart';
import '../model/token.dart';

class TokenModule extends Module<Token, String> {
  @override
  Token parser(Json json) => Token.fromJson(json);

  @override
  String get primary => 'token';

  @override
  String get table => 'token';
}

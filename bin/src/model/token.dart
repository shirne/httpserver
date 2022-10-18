import '../core/model.dart';
import '../globals.dart';

class Token extends Model<String> {
  Token({
    required this.token,
    required this.refreshToken,
    this.expireIn = 7200,
  });

  Token.fromJson(Json? json)
      : this(
          token: json?['token'] ?? '',
          refreshToken: json?['refresh_token'] ?? '',
          expireIn: json?['expire_in'] ?? 7200,
        );

  final String token;
  final String refreshToken;
  final int expireIn;

  @override
  String get primary => token;

  @override
  Token copyWith({
    String? token,
    String? refreshToken,
    int? expireIn,
  }) {
    return Token(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      expireIn: expireIn ?? this.expireIn,
    );
  }

  @override
  Json toJson([bool excludePrimary = false]) => {
        'token': token,
        'refresh_token': refreshToken,
        'expire_in': expireIn,
      };
}

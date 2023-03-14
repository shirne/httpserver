import '../core/model.dart';
import '../globals.dart';

class Token extends Model<String> {
  Token({
    required this.token,
    required this.refreshToken,
    this.expireIn = 7200,
    this.userId = 0,
    this.platform = '',
    this.appid = '',
    this.createTime = 0,
    this.updateTime = 0,
  });

  Token.fromJson(Json? json)
      : this(
          token: json?['token'] ?? '',
          refreshToken: json?['refresh_token'] ?? '',
          expireIn: json?['expire_in'] ?? 7200,
          userId: json?['user_id'] ?? 0,
          platform: json?['platform'] ?? '',
          appid: json?['appid'] ?? '',
          createTime: json?['create_time'] ?? 0,
          updateTime: json?['update_time'] ?? 0,
        );

  final String token;
  final String refreshToken;
  final int expireIn;
  final int userId;
  final String platform;
  final String appid;
  final int createTime;
  final int updateTime;

  @override
  String get primary => token;

  @override
  Token copyWith({
    String? token,
    String? refreshToken,
    int? expireIn,
    int? userId,
    String? platform,
    String? appid,
    int? createTime,
    int? updateTime,
  }) {
    return Token(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      expireIn: expireIn ?? this.expireIn,
      userId: userId ?? this.userId,
      platform: platform ?? this.platform,
      appid: appid ?? this.appid,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }

  Json toToken() => {
        'token': token,
        'refresh_token': refreshToken,
        'expire_in': expireIn,
      };

  @override
  Json toJson([bool excludePrimary = false]) => {
        'token': token,
        'refresh_token': refreshToken,
        'expire_in': expireIn,
        'user_id': userId,
        'platform': platform,
        'appid': appid,
        'create_time': createTime,
        'update_time': updateTime,
      };
}

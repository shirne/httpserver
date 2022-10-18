import '../core/model.dart';
import '../globals.dart';

class User extends Model<int> {
  User({
    this.id = 0,
    this.username = '',
    this.password = '',
    this.salt = '',
    this.avatar = '',
    this.levelId = 0,
    this.agentId = 0,
    this.province = '',
    this.city = '',
    this.county = '',
    this.street = '',
    this.address = '',
    this.status = 0,
    this.createTime = 0,
    this.updateTime = 0,
  });

  User.fromJson(Json? json)
      : this(
          id: json?['id'] ?? 0,
          username: json?['username'] ?? '',
          password: json?['password'] ?? '',
          salt: json?['salt'] ?? '',
          avatar: json?['avatar'] ?? '',
          levelId: json?['level_id'] ?? 0,
          agentId: json?['agent_td'] ?? 0,
          province: json?['province'] ?? '',
          city: json?['city'] ?? '',
          county: json?['county'] ?? '',
          street: json?['street'] ?? '',
          address: json?['address'] ?? '',
          status: json?['status'] ?? 0,
          createTime: json?['create_time'] ?? 0,
          updateTime: json?['update_time'] ?? 0,
        );

  final int id;
  final String username;
  final String password;
  final String salt;
  final String avatar;
  final int levelId;
  final int agentId;
  final String province;
  final String city;
  final String county;
  final String street;
  final String address;
  final int status;
  final int createTime;
  final int updateTime;

  @override
  int get primary => id;

  @override
  User copyWith({
    int? id,
    String? username,
    String? password,
    String? salt,
    String? avatar,
    int? levelId,
    int? agentId,
    String? province,
    String? city,
    String? county,
    String? street,
    String? address,
    int? status,
    int? createTime,
    int? updateTime,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      salt: salt ?? this.salt,
      avatar: avatar ?? this.avatar,
      levelId: levelId ?? this.levelId,
      agentId: agentId ?? this.agentId,
      province: province ?? this.province,
      city: city ?? this.city,
      county: county ?? this.county,
      street: street ?? this.street,
      address: address ?? this.address,
      status: status ?? this.status,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }

  @override
  Json toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'salt': salt,
        'avatar': avatar,
        'level_id': levelId,
        'agent_id': agentId,
        'province': province,
        'city': city,
        'county': county,
        'street': street,
        'address': address,
        'status': status,
        'create_time': createTime,
        'update_time': updateTime,
      };
}

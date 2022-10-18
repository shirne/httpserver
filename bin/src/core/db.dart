import '../env.dart';
import '../globals.dart';
import 'driver/mysql.dart';

class Condition {
  const Condition(this.where, [this.params]);

  final String where;
  final Json? params;
}

class Limit {
  const Limit(int start, [int? count])
      : count = count ?? start,
        start = count == null ? 0 : start;

  final int start;
  final int? count;
}

abstract class DB {
  factory DB() {
    if (_instance == null) {
      final env = Env();
      switch (env.type) {
        default:
          _instance = Mysql(env);
      }
    }
    return _instance!;
  }

  static DB? _instance;

  int get affectedRows;
  int get lastInsertID;

  Future<T?> fetch<T>(
    String table, {
    Condition? cond,
    String fields = '*',
    String? order,
    DataParser<T>? dataParser,
  });

  Future<List<T>> fetchAll<T>(
    String table, {
    Condition? cond,
    String fields = '*',
    String? order,
    Limit? limit,
    DataParser<T>? dataParser,
  });

  Future<int> count(String table, [Condition? cond]);

  Future<bool> insert(String table, Json data);

  Future<bool> update(
    String table,
    Json data, {
    required Condition cond,
  });

  Future<bool> delete(
    String table, {
    required Condition cond,
  });
}

import 'package:mysql_client/mysql_client.dart';

import '../env.dart';

typedef DataParser<T> = T? Function(Map<String, dynamic>);

class Mysql {
  final MySQLConnectionPool conn;

  static Mysql? _instance;

  factory Mysql({Env? env}) {
    _instance ??= Mysql._(env!);
    return _instance!;
  }

  Mysql._(Env env)
      : conn = MySQLConnectionPool(
          host: env.hostName,
          port: env.dataport,
          userName: env.userName,
          password: env.password,
          maxConnections: 10,
          databaseName: env.database, // optional,
        );

  Future<IResultSet> execute(String query) async {
    return await conn.execute(query);
  }

  String? toWhere(Map<String, dynamic>? condition, {String joiner = 'AND'}) {
    if (condition == null || condition.isEmpty) return null;
    return [
      for (MapEntry item in condition.entries)
        '`${item.key}`=\'${item.value}\'',
    ].join(' $joiner ');
  }

  Future<T?> fetch<T>(
    String table, {
    DataParser<T>? dataParser,
    String? where,
    Map<String, dynamic>? condition,
    String fields = '*',
    String? order,
  }) async {
    final whereOr = where ?? toWhere(condition);
    final whereStr = whereOr == null ? '' : ' WHERE $whereOr';
    final orderStr = order == null ? '' : ' ORDER BY $order';

    final sql = "SELECT $fields FROM `$table` $whereStr $orderStr";
    final result = await execute(sql);
    for (final row in result.rows) {
      return (dataParser ?? (data) => data as T).call(row.assoc());
    }
    return null;
  }

  Future<List<T>> fetchAll<T>(
    String table, {
    DataParser<T>? dataParser,
    String? where,
    Map<String, dynamic>? condition,
    String fields = '*',
    String? order,
  }) async {
    final whereOr = where ?? toWhere(condition);
    final whereStr = whereOr == null ? '' : ' WHERE $whereOr';
    final orderStr = order == null ? '' : ' ORDER BY $order';

    final sql = "SELECT $fields FROM `$table` $whereStr $orderStr";
    final result = await execute(sql);
    final list = <T>[];
    for (final row in result.rows) {
      final pRow = (dataParser ?? (data) => data as T).call(row.assoc());
      if (pRow != null) list.add(pRow);
    }
    return list;
  }

  Future<bool> insert(String table, Map<String, dynamic> data) async {
    final fields = [];
    final values = [];
    for (String k in data.keys) {
      fields.add(k);
      values.add('?');
    }
    final stmt = await conn.prepare(
      "INSERT INTO `$table` "
      "(`${fields.join('`, `')}`)"
      " VALUES (${values.join(', ')})",
    );
    final result = await stmt.execute(data.values.toList());
    return result.affectedRows.toInt() > 0;
  }

  Future<bool> update(String table, Map<String, dynamic> data) async {
    final sets = [];
    for (String k in data.keys) {
      sets.add('`$k` = ?');
    }
    final stmt = await conn.prepare(
      "UPDATE `$table` SET"
      " ${sets.join(', ')}",
    );
    final result = await stmt.execute(data.values.toList());
    return result.affectedRows.toInt() > 0;
  }

  Future<bool> delete(
    String table, {
    String? where,
    Map<String, dynamic>? condition,
  }) async {
    final whereOr = where ?? toWhere(condition);
    final whereStr = whereOr == null ? '' : ' WHERE $whereOr';
    final sql = "DELETE FROM `$table` $whereStr";
    final result = await execute(sql);
    return result.affectedRows.toInt() > 0;
  }
}

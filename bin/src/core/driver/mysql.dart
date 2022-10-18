import 'package:mysql_client/mysql_client.dart';

import '../../env.dart';
import '../../globals.dart';
import '../db.dart';

class Mysql implements DB {
  final MySQLConnectionPool conn;

  Mysql(Env env)
      : conn = MySQLConnectionPool(
          host: env.hostName,
          port: env.dataport,
          userName: env.userName,
          password: env.password,
          maxConnections: 10,
          databaseName: env.database, // optional,
        );

  int? _affectedRows;
  int? _lastInsertID;

  @override
  int get affectedRows => _affectedRows ?? 0;

  @override
  int get lastInsertID => _lastInsertID ?? 0;

  Future<IResultSet> _execute(
    String query, [
    Json? params,
  ]) async {
    final result = await conn.execute(query, params);
    _affectedRows = result.affectedRows.toInt();
    final id = result.lastInsertID.toInt();
    if (id > 0) {
      _lastInsertID = id;
    }
    return result;
  }

  @override
  Future<T?> fetch<T>(
    String table, {
    Condition? cond,
    String fields = '*',
    String? order,
    DataParser<T>? dataParser,
  }) async {
    final whereStr =
        (cond?.where.isEmpty ?? true) ? '' : ' WHERE ${cond!.where}';
    final orderStr = order == null ? '' : ' ORDER BY $order';

    final sql = 'SELECT $fields FROM `$table` $whereStr $orderStr LIMIT 1';
    final result = await _execute(sql, cond?.params);
    for (final row in result.rows) {
      return (dataParser ?? (data) => data as T).call(row.assoc());
    }
    return null;
  }

  @override
  Future<List<T>> fetchAll<T>(
    String table, {
    Condition? cond,
    String fields = '*',
    String? order,
    Limit? limit,
    DataParser<T>? dataParser,
  }) async {
    final whereStr =
        (cond?.where.isEmpty ?? true) ? '' : ' WHERE ${cond!.where}';
    final orderStr = order == null ? '' : ' ORDER BY $order';
    final limitStr =
        limit == null ? '' : ' LIMIT ${limit.start},{$limit.count}';

    final sql = 'SELECT $fields FROM `$table` $whereStr $orderStr $limitStr';
    final result = await _execute(sql, cond?.params);
    final list = <T>[];
    for (final row in result.rows) {
      final pRow = (dataParser ?? (data) => data as T).call(row.assoc());
      if (pRow != null) list.add(pRow);
    }
    return list;
  }

  @override
  Future<int> count(String table, [Condition? cond]) async {
    final whereStr =
        (cond?.where.isEmpty ?? true) ? '' : ' WHERE ${cond!.where}';
    final sql = 'SELECT count(0) FROM `$table` $whereStr ';
    final result = await _execute(sql, cond?.params);

    return int.parse(result.rows.first.colAt(0)!);
  }

  @override
  Future<bool> insert(String table, Map<String, dynamic> data) async {
    final fields = [];
    final values = [];
    for (String k in data.keys) {
      fields.add(k);
      values.add('?');
    }
    final stmt = await conn.prepare(
      'INSERT INTO `$table` '
      "(`${fields.join('`, `')}`)"
      " VALUES (${values.join(', ')})",
    );
    final result = await stmt.execute(data.values.toList());
    _affectedRows = result.affectedRows.toInt();
    _lastInsertID = result.lastInsertID.toInt();
    return _affectedRows! > 0;
  }

  @override
  Future<bool> update(
    String table,
    Map<String, dynamic> data, {
    required Condition cond,
  }) async {
    final sets = [];

    for (String k in data.keys) {
      sets.add('`$k` = :upk_$k');
    }

    final sql = 'UPDATE `$table` SET'
        " ${sets.join(', ')} WHERE ${cond.where}";
    final result = await _execute(sql, {
      for (MapEntry m in data.entries) 'upk_${m.key}': m.value,
      ...?cond.params,
    });
    _affectedRows = result.affectedRows.toInt();
    return _affectedRows! > 0;
  }

  @override
  Future<bool> delete(
    String table, {
    required Condition cond,
  }) async {
    final sql = 'DELETE FROM `$table` WHERE ${cond.where}';
    final result = await _execute(sql, cond.params);

    _affectedRows = result.affectedRows.toInt();
    return _affectedRows! > 0;
  }
}

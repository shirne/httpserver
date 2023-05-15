import '../globals.dart';
import 'db.dart';
import 'model.dart';

class Paginator<M> {
  Paginator({
    this.page = 1,
    this.totalPage = 1,
    this.count = 0,
    required this.list,
  });

  final int page;
  final int totalPage;
  final int count;
  final List<M> list;
}

abstract class Module<M extends Model, T> {
  DB get db => DB();
  String get table;
  String get primary;

  M parser(Json json);

  Future<M?> find(T value) {
    return db.fetch(
      table,
      cond: Condition('$primary = :value', {'value': value}),
      dataParser: parser,
    );
  }

  Future<M?> findCond(Condition cond) {
    return db.fetch(
      table,
      cond: cond,
      dataParser: parser,
    );
  }

  Future<List<M>> select(
    Condition cond, {
    String fields = '*',
    String? order,
    int? count,
  }) {
    return db.fetchAll(
      table,
      cond: cond,
      fields: fields,
      order: order,
      limit: count == null ? null : Limit(count),
    );
  }

  Future<Paginator<M>> paginate(
    Condition cond, {
    String fields = '*',
    String? order,
    int page = 1,
    int pagesize = 10,
  }) async {
    final count = await db.count(table, cond);
    final pageCount = (count / pagesize).ceil();
    final limit = Limit((page - 1) * pagesize, pagesize);
    final list = await db.fetchAll<M>(
      table,
      cond: cond,
      fields: fields,
      order: order,
      limit: limit,
      dataParser: parser,
    );
    return Paginator(
      page: page,
      totalPage: pageCount,
      count: count,
      list: list,
    );
  }

  Future<bool> update(M model) {
    return db.update(
      table,
      model.toJson(true),
      cond: Condition('`$primary`=:primary', {'primary': model.primary}),
    );
  }

  Future<bool> updateCond(Condition cond, Json data) {
    return db.update(
      table,
      data,
      cond: cond,
    );
  }

  Future<bool> insert(M model) {
    return db.insert(table, model.toJson(true));
  }

  Future<bool> delete(T value) {
    return db.delete(
      table,
      cond: Condition('`$primary`=:primary', {'primary': value}),
    );
  }

  Future<bool> deleteCond(Condition cond) {
    return db.delete(
      table,
      cond: cond,
    );
  }
}

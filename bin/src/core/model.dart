import 'dart:convert';

import '../globals.dart';

abstract class Model<T> {
  T get primary;

  Model copyWith();

  Json toJson();

  @override
  String toString() => jsonEncode(toJson());
}

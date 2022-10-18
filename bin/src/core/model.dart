import 'dart:convert';

import '../globals.dart';

abstract class Model<T> {
  T get primary;

  Model copyWith();

  Json toJson([bool excludePrimary = false]);

  @override
  String toString() => jsonEncode(toJson());
}

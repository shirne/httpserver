import 'dart:convert';

import '../globals.dart';

abstract class Model<T> {
  T get primary;

  Model copyWith();

  Json toJson([bool excludePrimary = false]);

  @override
  String toString() => jsonEncode(toJson());
}

T? parseJson<T>(String? value) {
  if (value != null && value.isNotEmpty) {
    try {
      return jsonDecode(value);
    } catch (e) {
      logger.warning('parse json error: $value', e, StackTrace.current.cast(3));
    }
  }
  return null;
}

List<T>? parseList<T>(String value, [T Function(String)? parser]) {
  if (value.isNotEmpty) {
    return value.split(',').map<T>(parser ?? (e) => e as T).toList();
  }
  return null;
}

Map<String, T>? parseProps<T>(
  String value, [
  MapEntry<String, T> Function(String)? parser,
]) {
  if (value.isNotEmpty) {
    return Map.fromEntries(
      value.split(RegExp('[\r\n]+')).map<MapEntry<String, T>>(
            parser ??
                (e) {
                  final parts = e.split(RegExp(':'));
                  return MapEntry(parts[0], parts[1] as T);
                },
          ),
    );
  }
  return null;
}

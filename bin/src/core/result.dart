import 'dart:convert';

class Result<T> {
  final int code;
  final String message;
  final T? data;
  final String url;

  Result({
    this.code = 0,
    this.message = 'ok',
    this.data,
    this.url = '',
  });

  Result.error(
    this.message, {
    this.code = -1,
    this.data,
    this.url = '',
  });

  Result.success(
    this.data, {
    this.code = 0,
    this.message = 'ok',
    this.url = '',
  });

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        if (data != null) 'data': data,
        if (url.isNotEmpty) 'url': url,
      };

  @override
  String toString() => jsonEncode(toJson());
}

const keyToken = 'token';
const keyIsLogin = 'is_login';

typedef Json = Map<String, dynamic>;

typedef DataParser<T> = T? Function(Json);

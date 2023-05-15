const keyToken = 'token';
const keyIsLogin = 'is_login';

const errorNeedLogin = 99;
const errorLoginFailed = 101;
const errorNeedVerify = 104;
const errorNeedRegister = 109;
const errorRegisterFailed = 111;
const errorTokenInvaild = 102;
const errorTokenExpire = 103;
const errorRefreshTokenInvaild = 105;
const errorTmpTokenInvaild = 115;
const errorNeedOpenid = 112;
const errorMemberDisabled = 113;

typedef Json = Map<String, dynamic>;

typedef DataParser<T> = T? Function(Json);

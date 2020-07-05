import 'package:dio/dio.dart';

import 'http_error.dart';

class ApiInterceptor extends InterceptorsWrapper {
  @override
  Future onResponse(Response response) {
    if (response.data['errorCode'] == -1001) {
      //未登录 重新登录
      throw const UnAuthorizedException();
    }
    return super.onResponse(response);
  }
}

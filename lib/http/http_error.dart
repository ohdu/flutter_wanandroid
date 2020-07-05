import 'package:dio/dio.dart';

class HttpError {
  //请求成功
  static const int successCode = 0;

//加载之前
  static const int loadBefore = 5;
  //加载中
  static const int loading = 1;
  //加载成功
  static const int loadingSuccess = 2;
  //加载成功但是数据为空
  static const int loadingEmpty = 4;
  //加载失败
  static const int loadingError = 3;

  //重新登录
  static const int notLoggedIn = -1001;
  static bool hasSuccess(Map data) {
    if (data['errorCode'] == successCode) {
      return true;
    }
    return false;
  }

  static formatError(e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      throw Exception("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      throw Exception("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      throw Exception("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      throw Exception("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      throw Exception("请求取消");
    } else {
      throw Exception("未知错误");
    }
  }
}

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}

import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:wan_android/http/http_error.dart';
import 'package:wan_android/http/http_url.dart';
import 'package:wan_android/http/storage_manager.dart';

/// 网络请求 dio 封装
class DioManage {
  // 工厂模式
  factory DioManage() => _getInstance();
  static DioManage get instance => _getInstance();
  static DioManage _instance;
  Dio _dio;
  DioManage._internal() {
    _dio = Dio(BaseOptions(
        baseUrl: HttpUrl.baseUrl, responseType: ResponseType.plain));
    //开启日志打印
    _dio.interceptors.add(LogInterceptor(responseBody: false));

    _dio.interceptors.add(CookieManager(
        PersistCookieJar(dir: StorageManager.temporaryDirectory.path)));
  }
  static DioManage _getInstance() {
    if (_instance == null) {
      _instance = new DioManage._internal();
    }
    return _instance;
  }

  // dio get请求
  void dioGet(String urlPath,
      {Map<String, dynamic> queryParameters,
      Function then,
      Function catchError,
      Function whenComplete}) async {
    int loadingState = HttpError.loading;
    try {
      Response response =
          await _dio.get(urlPath, queryParameters: queryParameters);
      Map<String, dynamic> map = jsonDecode(response.data);

      print("网络请求get:" + jsonEncode(map));
      if (map['errorCode'] == HttpError.successCode) {
        if (then != null) {
          then(map['data']);
        }
        loadingState = HttpError.loadingSuccess;
      } else {
        if (catchError != null) {
          catchError(map['errorMsg']);
        }
        loadingState = HttpError.loadingError;
      }
    } catch (e) {
      // HttpError.formatError(e);
      loadingState = HttpError.loadingError;
      if (catchError != null) {
        catchError('网络请求异常!');
      }
    } finally {
      if (whenComplete != null) {
        whenComplete(loadingState);
      }
    }
  }

  // dio get请求
  void dioPost(String urlPath,
      {Map<String, dynamic> queryParameters,
      Function then,
      Function catchError,
      Function whenComplete}) async {
    int loadingState = HttpError.loading;
    try {
      Response response =
          await _dio.post(urlPath, queryParameters: queryParameters);
      Map<String, dynamic> map = jsonDecode(response.data);
      print("网络请求post:" + jsonEncode(map));
      if (map['errorCode'] == HttpError.successCode) {
        if (then != null) {
          then(map['data']);
        }
        loadingState = HttpError.loadingSuccess;
      } else {
        if (catchError != null) {
          catchError(map['errorMsg']);
        }
        loadingState = HttpError.loadingError;
      }
    } catch (e) {
      // HttpError.formatError(e);
      if (catchError != null) {
        catchError('网络请求异常');
      }
      loadingState = HttpError.loadingError;
    } finally {
      if (whenComplete != null) {
        whenComplete(loadingState);
      }
    }
  }
}

//根据网络请求状态加载对应的布局
// 加载成功/失败

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_android/http/http_error.dart';

class HttpStateWidget {
  static Widget httpWidget(int httpStateCode, Widget laodSuccessWidget,
      {Function onTap, Widget loadingBeforeWidget}) {
    switch (httpStateCode) {
      case HttpError.loadBefore:
        if (loadingBeforeWidget == null) {
          return Text('');
        }
        return loadingBeforeWidget;
      case HttpError.loading:
        return _httpLoading();
      case HttpError.loadingSuccess:
        return laodSuccessWidget;
      case HttpError.loadingEmpty:
        return _httpEmpty();
      case HttpError.loadingError:
        return GestureDetector(
          child: _httpError(),
          onTap: onTap,
        );

      default:
        return Text('');
    }
  }

  static Widget _httpError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/load_error.png',
            width: 80,
            height: 80,
          ),
          SizedBox(
            height: 22,
          ),
          Text(
            '加载失败,请下拉或点击重新加载!',
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }

  static Widget _httpEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/load_empty.png',
            width: 80,
            height: 80,
          ),
          SizedBox(
            height: 22,
          ),
          Text(
            '哇哦,该板块暂时无数据哦!',
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }

  static Widget _httpLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CupertinoActivityIndicator(
            radius: 20,
          ),
          SizedBox(
            height: 22,
          ),
          Text(
            '加载中,请稍等...',
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}

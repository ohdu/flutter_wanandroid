import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wan_android/bean/user_bean.dart';
import 'package:wan_android/pages/main_page/home_page.dart';
import 'package:wan_android/pages/navi_page/navi_page.dart';
import 'package:wan_android/pages/system_page/system_page.dart';
import 'package:wan_android/utils/constant.dart';
import 'package:wan_android/utils/shared_preferences_util.dart';

class IndexPageProvider with ChangeNotifier {
  int _currentIndex = 0;
  List<Widget> _pages;
  List<String> _appBarTitle = ['玩Android', '体系', '导航', '收藏'];
  IndexPageProvider() {
    _pages = [HomePage(), SystemPage(), NaviPage(), HomePage()];
    _appBarTitle = ['玩Android', '体系', '导航', '收藏'];
  }

  int get currentIndex => _currentIndex;

  String get appBarTitle => _appBarTitle[_currentIndex];

  Widget get page => _pages[_currentIndex];

  List<Widget> get pages => _pages;

  void setCurrentIndex(int tapIndex) {
    if (tapIndex != _currentIndex) {
      _currentIndex = tapIndex;
      notifyListeners();
    }
  }

  // UserBean userInfo() {
  //   SharedPreferencesUtil.getString(Constant.spKeyUser).then((onValue) {
  //     return UserBean.fromJson(jsonDecode(onValue));
  //   });
  //   return null;
  // }

  UserBean userInfo() {
    SharedPreferencesUtil.getString(Constant.spKeyUser).then((onValue) {
      return UserBean.fromJson(jsonDecode(onValue));
    });
    return null;
  }
}

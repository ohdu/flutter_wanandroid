import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wan_android/http/dio_manage.dart';
import 'package:wan_android/http/http_url.dart';
import 'package:wan_android/utils/constant.dart';
import 'package:wan_android/utils/shared_preferences_util.dart';
import 'package:wan_android/utils/toast_util.dart';

///用户登录
class UserLoginPage extends StatefulWidget {
  UserLoginPage({Key key}) : super(key: key);

  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  TextEditingController _passWordController;
  TextEditingController _userNameController;
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passWordController = TextEditingController();
    _scaffoldKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Container(
          padding: EdgeInsets.all(22),
          child: Column(children: <Widget>[
            TextField(
              controller: _userNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(0),
                hintText: '请输入账号',
                labelText: '账号',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            Divider(
              height: 30,
            ),
            TextField(
              controller: _passWordController,
              //密文形式
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(0),
                hintText: '请输入密码',
                labelText: '密码',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: RaisedButton(
                onPressed: _startLogin,
                textColor: Colors.white,
                color: Colors.blue,
                child: Text("登录"),
              ),
            )
          ])),
    );
  }

  //去登陆
  void _startLogin() {
    String userName = _userNameController.text.toString().trim();
    String passWord = _passWordController.text.toString().trim();
    if (userName.isEmpty) {
      ToastUtil.showSnackBar(_scaffoldKey, "用户名不能为空!");
      return;
    }
    if (passWord.isEmpty) {
      ToastUtil.showSnackBar(_scaffoldKey, "密码不能为空!");
      return;
    }
    //关闭软键盘
    FocusScope.of(context).requestFocus(FocusNode());
    DioManage.instance.dioPost(HttpUrl.login,
        queryParameters: {"username": userName, "password": passWord},
        then: (data) {
      SharedPreferencesUtil.putString(Constant.spKeyUser, json.encode(data));
      Navigator.pop(context);
    }, catchError: (errorMsg) {
      ToastUtil.showSnackBar(_scaffoldKey, errorMsg);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passWordController.dispose();
  }
}

import 'package:flutter/material.dart';

class LoadingDialog {
  //是否正在显示
  //true 在显示  false 未显示
  bool _isShow = false;
  BuildContext context;
  LoadingDialog(this.context);
  void showLoading({String msg = '加载中,请稍等...'}) {
    if (!_isShow) {
      showDialog(
          context: context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new LoadingDialogWidget(
              //调用对话框
              text: msg,
            );
          });
      _isShow = true;
    }
  }

  void disMissLoading() {
    if (_isShow) {
      Navigator.pop(context);
      _isShow = false;
    }
  }
}

class LoadingDialogWidget extends Dialog {
  final String text;

  LoadingDialogWidget({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          width: 120.0,
          height: 120.0,
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 22.0,
                  ),
                  child: Text(text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

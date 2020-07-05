import 'package:wan_android/bean/bean_factory.dart';

class BaseListBean<T> {
  int errorCode;
  String errorMsg;
  List<T> data;

  BaseListBean({this.errorCode, this.errorMsg, this.data});

  factory BaseListBean.fromJson(json) {
    List<T> mData = List();
    if (json['data'] != null) {
      //遍历data并转换为我们传进来的类型
      (json['data'] as List).forEach((v) {
        mData.add(BeanFactory.generateOBJ<T>(v));
      });
    }

    return BaseListBean(
      errorCode: json["errorCode"],
      errorMsg: json["errorMsg"],
      data: mData,
    );
  }
}

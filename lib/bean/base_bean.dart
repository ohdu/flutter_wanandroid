import 'package:wan_android/bean/bean_factory.dart';

class BaseBean<T> {
  int errorCode;
  String errorMsg;
  T data;

  BaseBean({this.errorCode, this.errorMsg, this.data});

  factory BaseBean.fromJson(json) {
    return BaseBean(
      errorCode: json["errorCode"],
      errorMsg: json["errorMsg"],
      // data值需要经过工厂转换为我们传进来的类型
      data: BeanFactory.generateOBJ<T>(json["data"]),
    );
  }
}

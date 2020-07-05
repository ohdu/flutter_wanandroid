import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'http/api.dart';

//全局provider管理
List<SingleChildWidget> providers = [
  // ...independentServices,
  // ...dependentServices
];

List<SingleChildWidget> independentServices = [
  // ChangeNotifierProvider()
  Provider(create: (_) => Api()),
];

List<SingleChildWidget> dependentServices = [
  //这里使用ProxyProvider来定义需要依赖其他Provider的服务
];

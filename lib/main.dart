import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_android/http/storage_manager.dart';

import 'provider_setup.dart';
import 'utils/route_paths.dart';
import 'utils/router.dart';

void main() async {
  //runApp之前要想初始化一些数据 则必须显示调用WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WanAndroid',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RoutePaths.indexPage,
      onGenerateRoute: Router.generateRoute,
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: providers,
//       child: MaterialApp(
//         title: 'WanAndroid',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         initialRoute: RoutePaths.indexPage,
//         onGenerateRoute: Router.generateRoute,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_android/bean/user_bean.dart';
import 'package:wan_android/pages/person_page/user_login_page.dart';
import 'package:wan_android/provider/index_page_provider.dart';
import 'package:wan_android/pages/search_page/search_bar_delegate.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IndexPageProvider(),
      child: Consumer(
        builder: (BuildContext context, IndexPageProvider value, Widget child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(value.appBarTitle),
              actions: <Widget>[
                GestureDetector(
                  child: Container(
                    child: Icon(Icons.search),
                    margin: EdgeInsets.fromLTRB(0, 0, 18, 0),
                  ),
                  onTap: () {
                    //跳转到搜索
                    // Navigator.push(context, MaterialPageRoute(builder: (_) {
                    //   return SearchPage();
                    // }
                    // ));
                    showSearch(context: context, delegate: SearchBarDelegate());
                  },
                )
              ],
            ),
            body: IndexedStack(
              children: value.pages,
              index: value.currentIndex,
            ),
            bottomNavigationBar: _mainBottom(value.currentIndex, (tapIndex) {
              value.setCurrentIndex(tapIndex);
            }),
            drawer: _mainDrawer(value.userInfo(), context),
          );
        },
      ),
    );
  }

  ///侧边栏
  Widget _mainDrawer(UserBean user, BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        GestureDetector(
          child: UserAccountsDrawerHeader(
            accountName: Text(user != null ? user.username : "请登录"),
            accountEmail: Text(user != null ? user.email : 'lidaryl@163.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user != null
                  ? 'https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=218375221,1552855610&fm=111&gp=0.jpg'
                  : 'https://dss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2477435147,683021756&fm=26&gp=0.jpg'),
            ),
          ),
          onTap: () {
            //如果没登录 去登陆
            if (user == null) {
              Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                return UserLoginPage();
              }));
            } else {
              //进入个人详情页
            }
          },
        )
      ]),
    );
  }

  ///底部导航栏
  Widget _mainBottom(int currenctIndex, Function onTap) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        _bottomNavigtionBarItem('首页', Icons.home, 0, currenctIndex),
        _bottomNavigtionBarItem('体系', Icons.phonelink_setup, 1, currenctIndex),
        _bottomNavigtionBarItem('导航', Icons.navigation, 2, currenctIndex),
        _bottomNavigtionBarItem('收藏', Icons.collections, 3, currenctIndex),
      ],
      currentIndex: currenctIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (tapIndex) {
        onTap(tapIndex);
      },
    );
  }

  BottomNavigationBarItem _bottomNavigtionBarItem(
      String text, IconData iconData, int position, int currenctIndex) {
    return BottomNavigationBarItem(
        icon: Icon(iconData,
            color: currenctIndex == position ? Colors.blue : Colors.grey),
        title: Text(
          text,
          style: TextStyle(
              color: currenctIndex == position ? Colors.blue : Colors.grey),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:wan_android/http/dio_manage.dart';
import 'package:wan_android/http/http_error.dart';
import 'package:wan_android/http/http_url.dart';
import 'package:wan_android/pages/details_page/details_page.dart';
import 'package:wan_android/utils/toast_util.dart';
import 'package:wan_android/widget/http_state_widget.dart';

//导航数据
class NaviPage extends StatefulWidget {
  NaviPage({Key key}) : super(key: key);

  @override
  _NaviPageState createState() => _NaviPageState();
}

class _NaviPageState extends State<NaviPage> {
  List _naviData;
  int _loadingCode = HttpError.loading;
  GlobalKey<ScaffoldState> _globalKey;
  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey();
    _getNaviData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        body: HttpStateWidget.httpWidget(
          _loadingCode,
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(12),
                    child: Text(
                      _naviData[index]['name'],
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  wrapWidget(index)
                ],
              );
            },
            itemCount: _naviData.length,
          ),
        ));
  }

  Widget wrapWidget(int index) {
    List articles = _naviData[index]['articles'];
    List<Widget> wraps = List();
    articles.forEach((data) {
      wraps.add(GestureDetector(
        child: Container(
          padding: EdgeInsets.all(4),
          child: Text(data['title']),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: Colors.grey[400])),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DetailsPage(
              data['link'],
              title: data['title'],
            );
          }));
        },
      ));
    });
    return Container(
      margin: EdgeInsets.all(12),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: wraps,
      ),
    );
  }

  void _getNaviData() {
    DioManage.instance.dioGet(HttpUrl.naviJson, then: (data) {
      _naviData = data;
    }, catchError: (errorMsg) {
      ToastUtil.showSnackBar(_globalKey, errorMsg);
    }, whenComplete: (laodingCode) {
      setState(() {
        _loadingCode = laodingCode;
      });
    });
  }
}

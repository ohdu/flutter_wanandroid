import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

///内容详情
// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  String title;
  String url;
  DetailsPage(this.url, {Key key, this.title = 'WebView'}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  FlutterWebviewPlugin _flutterWebviewPlugin;

  double _lineProgress = 0;
  @override
  void initState() {
    super.initState();
    _flutterWebviewPlugin = new FlutterWebviewPlugin();
    _flutterWebviewPlugin.onProgressChanged.listen((progress) {
      print(progress);
      setState(() {
        _lineProgress = progress;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: Text(widget.title),
        //进度条
        bottom: PreferredSize(
          child: _progressBar(_lineProgress),
          preferredSize: Size.fromHeight(1.0),
        ),
      ),
    );
  }

  Widget _progressBar(double progress) {
    return Container(
      height: 2.0,
      child: LinearProgressIndicator(
        backgroundColor: Colors.white70.withOpacity(0),
        value: progress == 1.0 ? 0 : progress,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    );
  }

  @override
  void dispose() {
    _flutterWebviewPlugin.dispose();
    super.dispose();
  }
}

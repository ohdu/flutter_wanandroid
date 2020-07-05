 

import 'package:flutter/material.dart';
import 'package:wan_android/http/http_error.dart';
import 'package:wan_android/widget/http_state_widget.dart';

class SearchBarDelegate extends SearchDelegate<String> {
  int httpStateCode = HttpError.loadBefore; 
  //清空按钮
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "", //搜索值置空
      )
    ];
  }

  //返回上级按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => close(context, null) //点击时关闭整个搜索页面
        );
  }

  //搜到到内容后的展现
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  //设置推荐
  @override
  Widget buildSuggestions(BuildContext context) {
    print('===================$query');
    return HttpStateWidget.httpWidget(httpStateCode, Text('data'));
    // final suggestionsList= query.isEmpty
    //   ? recentSuggest
    //   : searchList.where((input)=> input.startsWith(query)).toList();

    // return ListView.builder(
    //   itemCount:suggestionsList.length,
    //   itemBuilder: (context,index) => ListTile(
    //     title: RichText( //富文本
    //       text: TextSpan(
    //         text: suggestionsList[index].substring(0,query.length),
    //         style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
    //         children: [
    //           TextSpan(
    //             text: suggestionsList[index].substring(query.length),
    //             style: TextStyle(color: Colors.grey)
    //           )
    //         ]
    //       ),
    //     ),
    //   ),
    // ); r
  }

  // 主题色
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        primaryColor: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle:
              Theme.of(context).textTheme.title.copyWith(color: Colors.white),
        ));
  }
}

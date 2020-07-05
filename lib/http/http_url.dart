class HttpUrl {
  static const String baseUrl = "https://www.wanandroid.com";

  //登录
  static const String login = "/user/login";

  //首页banner
  static const String homeBanner = '/banner/json';

  //首页文章
  static String homeArticle(int page) => '/article/list/$page/json';

  //导航数据
  static const String naviJson = '/navi/json';
}

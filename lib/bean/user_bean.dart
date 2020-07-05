class UserBean {
  bool admin;
  List<dynamic> chapterTops;
  List<dynamic> collectIds;
  String email;
  String icon;
  int id;
  String nickname;
  String password;
  String publicName;
  String token;
  int type;
  String username;

  UserBean({
    this.admin,
    this.chapterTops,
    this.collectIds,
    this.email,
    this.icon,
    this.id,
    this.nickname,
    this.password,
    this.publicName,
    this.token,
    this.type,
    this.username,
  });

  factory UserBean.fromJson(Map<String, dynamic> json) => UserBean(
        admin: json["admin"],
        chapterTops: List<dynamic>.from(json["chapterTops"].map((x) => x)),
        collectIds: List<dynamic>.from(json["collectIds"].map((x) => x)),
        email: json["email"],
        icon: json["icon"],
        id: json["id"],
        nickname: json["nickname"],
        password: json["password"],
        publicName: json["publicName"],
        token: json["token"],
        type: json["type"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "admin": admin,
        "chapterTops": List<dynamic>.from(chapterTops.map((x) => x)),
        "collectIds": List<dynamic>.from(collectIds.map((x) => x)),
        "email": email,
        "icon": icon,
        "id": id,
        "nickname": nickname,
        "password": password,
        "publicName": publicName,
        "token": token,
        "type": type,
        "username": username,
      };
}

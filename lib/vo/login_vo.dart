import 'package:flutter_redux_mall/vo/base_data.dart';

class LoginVo {
  String token;
  UserInfo userInfo;
  int cartCount;

  LoginVo({this.token, this.userInfo, this.cartCount});

  LoginVo.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
    cartCount = json['cart_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo.toJson();
    }
    data['cart_count'] = this.cartCount;
    return data;
  }
}

class UserInfo {
  int userId;
  int sex;
  int birthday;
  String headPic;
  String nickname;

  UserInfo({this.userId, this.sex, this.birthday, this.headPic, this.nickname});

  UserInfo.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    sex = json['sex'];
    birthday = json['birthday'];
    headPic = json['head_pic'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['sex'] = this.sex;
    data['birthday'] = this.birthday;
    data['head_pic'] = this.headPic;
    data['nickname'] = this.nickname;
    return data;
  }
}
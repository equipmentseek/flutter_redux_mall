abstract class BaseData<T> {
  int code;
  dynamic data;
  String msg;

  BaseData({this.code, this.data, this.msg});

  BaseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? createData(json['data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['msg'] = this.msg;
    return data;
  }

  T createData(dynamic json);
}

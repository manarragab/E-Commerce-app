
class PostLogin {
  String? email;
  String? password;

  PostLogin({this.email, this.password});

  PostLogin.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    password = json["password"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["email"] = email;
    _data["password"] = password;
    return _data;
  }
}
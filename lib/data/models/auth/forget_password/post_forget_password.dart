
class PostForgetPassword {
  String? email;

  PostForgetPassword({this.email});

  PostForgetPassword.fromJson(Map<String, dynamic> json) {
    email = json["email"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["email"] = email;
    return _data;
  }
}
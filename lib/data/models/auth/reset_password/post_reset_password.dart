
class PostResetPassword {
  String? email;
  String? otp;
  String? newPassword;

  PostResetPassword({this.email, this.otp, this.newPassword});

  PostResetPassword.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    otp = json["otp"];
    newPassword = json["newPassword"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["email"] = email;
    _data["otp"] = otp;
    _data["newPassword"] = newPassword;
    return _data;
  }
}
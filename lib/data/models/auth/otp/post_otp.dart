
class PostOtp {
  String? email;
  String? otp;

  PostOtp({this.email, this.otp});

  PostOtp.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    otp = json["otp"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["email"] = email;
    _data["otp"] = otp;
    return _data;
  }
}
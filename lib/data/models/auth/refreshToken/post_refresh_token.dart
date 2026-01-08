
class PostRefreshToken {
  String? refreshToken;
  bool? useCookies;

  PostRefreshToken({this.refreshToken, this.useCookies});

  PostRefreshToken.fromJson(Map<String, dynamic> json) {
    refreshToken = json["refreshToken"];
    useCookies = json["useCookies"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["refreshToken"] = refreshToken;
    _data["useCookies"] = false;
    return _data;
  }
}
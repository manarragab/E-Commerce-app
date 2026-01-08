
class RefreshTokenResponse {
  String? accessToken;
  String? expiresAtUtc;
  String? refreshToken;

  RefreshTokenResponse({this.accessToken, this.expiresAtUtc, this.refreshToken});

  RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json["accessToken"];
    expiresAtUtc = json["expiresAtUtc"];
    refreshToken = json["refreshToken"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["accessToken"] = accessToken;
    _data["expiresAtUtc"] = expiresAtUtc;
    _data["refreshToken"] = refreshToken;
    return _data;
  }
}
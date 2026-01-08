
class LoginResponse {
  String? accessToken;
  String? expiresAtUtc;
  String? refreshToken;

  LoginResponse({this.accessToken, this.expiresAtUtc, this.refreshToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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
  @override
  String toString() {
    return 'LoginResponse{accessToken: $accessToken, expiresAtUtc: $expiresAtUtc, refreshToken: $refreshToken}';
  }
}

class RegisterResponse {
  String? message;

  RegisterResponse({this.message});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    return _data;
  }
}
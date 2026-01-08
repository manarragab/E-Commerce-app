
class PostApiKey {
  String? apiKey;

  PostApiKey({this.apiKey});

  PostApiKey.fromJson(Map<String, dynamic> json) {
    apiKey = json["api_key"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["api_key"] = apiKey;
    return _data;
  }
}
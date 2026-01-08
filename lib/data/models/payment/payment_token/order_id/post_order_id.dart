
class PostOrderId {
  String? authToken;
  String? apiSource;
  String? amountCents;
  String? currency;
  List<dynamic>? items;

  PostOrderId({this.authToken, this.apiSource, this.amountCents, this.currency, this.items});

  PostOrderId.fromJson(Map<String, dynamic> json) {
    authToken = json["auth_token"];
    apiSource = json["api_source"];
    amountCents = json["amount_cents"];
    currency = json["currency"];
    items = json["items"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["auth_token"] = authToken;
    _data["api_source"] = apiSource;
    _data["amount_cents"] = amountCents;
    _data["currency"] = currency;
    if(items != null) {
      _data["items"] = items;
    }
    return _data;
  }
}
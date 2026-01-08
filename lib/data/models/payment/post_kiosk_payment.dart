
class PostPaymentKiosk {
  Source? source;
  String? paymentToken;

  PostPaymentKiosk({this.source, this.paymentToken});

  PostPaymentKiosk.fromJson(Map<String, dynamic> json) {
    source = json["source"] == null ? null : Source.fromJson(json["source"]);
    paymentToken = json["payment_token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(source != null) {
      _data["source"] = source?.toJson();
    }
    _data["payment_token"] = paymentToken;
    return _data;
  }
}

class Source {
  String? identifier;
  String? subtype;

  Source({this.identifier, this.subtype});

  Source.fromJson(Map<String, dynamic> json) {
    identifier = json["identifier"];
    subtype = json["subtype"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["identifier"] = identifier;
    _data["subtype"] = subtype;
    return _data;
  }
}
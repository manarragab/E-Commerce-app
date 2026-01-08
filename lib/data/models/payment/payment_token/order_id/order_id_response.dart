
class ResponseOrderId {
  int? id;
  String? createdAt;
  bool? deliveryNeeded;
  Merchant? merchant;
  dynamic collector;
  int? amountCents;
  dynamic shippingData;
  String? currency;
  bool? isPaymentLocked;
  bool? isReturn;
  bool? isCancel;
  bool? isReturned;
  bool? isCanceled;
  dynamic merchantOrderId;
  dynamic walletNotification;
  int? paidAmountCents;
  bool? notifyUserWithEmail;
  List<dynamic>? items;
  String? orderUrl;
  int? commissionFees;
  int? deliveryFeesCents;
  int? deliveryVatCents;
  String? paymentMethod;
  dynamic merchantStaffTag;
  String? apiSource;
  Data? data;
  String? paymentStatus;
  dynamic terminalVersion;
  String? token;
  String? url;

  ResponseOrderId({this.id, this.createdAt, this.deliveryNeeded, this.merchant, this.collector, this.amountCents, this.shippingData, this.currency, this.isPaymentLocked, this.isReturn, this.isCancel, this.isReturned, this.isCanceled, this.merchantOrderId, this.walletNotification, this.paidAmountCents, this.notifyUserWithEmail, this.items, this.orderUrl, this.commissionFees, this.deliveryFeesCents, this.deliveryVatCents, this.paymentMethod, this.merchantStaffTag, this.apiSource, this.data, this.paymentStatus, this.terminalVersion, this.token, this.url});

  ResponseOrderId.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    createdAt = json["created_at"];
    deliveryNeeded = json["delivery_needed"];
    merchant = json["merchant"] == null ? null : Merchant.fromJson(json["merchant"]);
    collector = json["collector"];
    amountCents = json["amount_cents"];
    shippingData = json["shipping_data"];
    currency = json["currency"];
    isPaymentLocked = json["is_payment_locked"];
    isReturn = json["is_return"];
    isCancel = json["is_cancel"];
    isReturned = json["is_returned"];
    isCanceled = json["is_canceled"];
    merchantOrderId = json["merchant_order_id"];
    walletNotification = json["wallet_notification"];
    paidAmountCents = json["paid_amount_cents"];
    notifyUserWithEmail = json["notify_user_with_email"];
    items = json["items"] ?? [];
    orderUrl = json["order_url"];
    commissionFees = json["commission_fees"];
    deliveryFeesCents = json["delivery_fees_cents"];
    deliveryVatCents = json["delivery_vat_cents"];
    paymentMethod = json["payment_method"];
    merchantStaffTag = json["merchant_staff_tag"];
    apiSource = json["api_source"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
    paymentStatus = json["payment_status"];
    terminalVersion = json["terminal_version"];
    token = json["token"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["created_at"] = createdAt;
    _data["delivery_needed"] = deliveryNeeded;
    if(merchant != null) {
      _data["merchant"] = merchant?.toJson();
    }
    _data["collector"] = collector;
    _data["amount_cents"] = amountCents;
    _data["shipping_data"] = shippingData;
    _data["currency"] = currency;
    _data["is_payment_locked"] = isPaymentLocked;
    _data["is_return"] = isReturn;
    _data["is_cancel"] = isCancel;
    _data["is_returned"] = isReturned;
    _data["is_canceled"] = isCanceled;
    _data["merchant_order_id"] = merchantOrderId;
    _data["wallet_notification"] = walletNotification;
    _data["paid_amount_cents"] = paidAmountCents;
    _data["notify_user_with_email"] = notifyUserWithEmail;
    if(items != null) {
      _data["items"] = items;
    }
    _data["order_url"] = orderUrl;
    _data["commission_fees"] = commissionFees;
    _data["delivery_fees_cents"] = deliveryFeesCents;
    _data["delivery_vat_cents"] = deliveryVatCents;
    _data["payment_method"] = paymentMethod;
    _data["merchant_staff_tag"] = merchantStaffTag;
    _data["api_source"] = apiSource;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    _data["payment_status"] = paymentStatus;
    _data["terminal_version"] = terminalVersion;
    _data["token"] = token;
    _data["url"] = url;
    return _data;
  }
}

class Data {
  Data();

  Data.fromJson(Map<String, dynamic> json) {

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};

    return _data;
  }
}

class Merchant {
  int? id;
  String? createdAt;
  List<String>? phones;
  dynamic companyEmails;
  String? companyName;
  String? state;
  String? country;
  String? city;
  String? postalCode;
  String? street;

  Merchant({this.id, this.createdAt, this.phones, this.companyEmails, this.companyName, this.state, this.country, this.city, this.postalCode, this.street});

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    createdAt = json["created_at"];
    phones = json["phones"] == null ? null : List<String>.from(json["phones"]);
    companyEmails = json["company_emails"];
    companyName = json["company_name"];
    state = json["state"];
    country = json["country"];
    city = json["city"];
    postalCode = json["postal_code"];
    street = json["street"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["created_at"] = createdAt;
    if(phones != null) {
      _data["phones"] = phones;
    }
    _data["company_emails"] = companyEmails;
    _data["company_name"] = companyName;
    _data["state"] = state;
    _data["country"] = country;
    _data["city"] = city;
    _data["postal_code"] = postalCode;
    _data["street"] = street;
    return _data;
  }
}
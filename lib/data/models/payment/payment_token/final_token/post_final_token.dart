
import 'package:ecommerce_app/data/remote_data/response_model.dart';

class PostFinalToken extends ResponseModel<BillingData>{
  String? authToken;
  int? amountCents;
  String? orderId;
  BillingData billingData; 
  String? currency;
  int? integrationId;
  String? lockOrderWhenPaid;

  PostFinalToken({
    this.authToken,
    this.amountCents,
    this.orderId,
    BillingData? billingData,
    this.currency,
    this.integrationId,
    this.lockOrderWhenPaid,
  }) : billingData = billingData ?? BillingData(); 

  PostFinalToken.fromJson(Map<String, dynamic> json)
      : billingData = json["billing_data"] == null 
            ? BillingData() 
            : BillingData.fromJson(json["billing_data"]) {
    authToken = json["auth_token"];
    amountCents = json["amount_cents"];
    orderId = json["order_id"];
    currency = json["currency"];
    integrationId = json["integration_id"];
    lockOrderWhenPaid = json["lock_order_when_paid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["auth_token"] = authToken;
    _data["amount_cents"] = amountCents;
    _data["order_id"] = orderId;
    _data["billing_data"] = billingData.toJson(); // always available
    _data["currency"] = currency;
    _data["integration_id"] = integrationId;
    _data["lock_order_when_paid"] = lockOrderWhenPaid;
    return _data;
  }
}

class BillingData {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? country;
  String? city;
  String? street;
  String? building;
  String? floor;
  String? apartment;
  String? postalCode;

  BillingData({this.firstName, this.lastName, this.email, this.phoneNumber, this.country, this.city, this.street, this.building, this.floor, this.apartment, this.postalCode});

  BillingData.fromJson(Map<String, dynamic> json) {
    firstName = json["first_name"];
    lastName = json["last_name"];
    email = json["email"];
    phoneNumber = json["phone_number"];
    country = json["country"];
    city = json["city"];
    street = json["street"];
    building = json["building"];
    floor = json["floor"];
    apartment = json["apartment"];
    postalCode = json["postal_code"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["email"] = email;
    _data["phone_number"] = phoneNumber;
    _data["country"] = country;
    _data["city"] = city;
    _data["street"] = street;
    _data["building"] = building;
    _data["floor"] = floor;
    _data["apartment"] = apartment;
    _data["postal_code"] = postalCode;
    return _data;
  }
}
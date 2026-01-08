
class KioskPaymentResponse {
  int? id;
  bool? pending;
  int? amountCents;
  bool? success;
  bool? isAuth;
  bool? isCapture;
  bool? isStandalonePayment;
  bool? isVoided;
  bool? isRefunded;
  bool? is3DSecure;
  int? integrationId;
  int? profileId;
  bool? hasParentTransaction;
  Order? order;
  String? createdAt;
  List<dynamic>? transactionProcessedCallbackResponses;
  String? currency;
  SourceData? sourceData;
  String? apiSource;
  dynamic terminalId;
  int? merchantCommission;
  int? acceptFees;
  dynamic installment;
  List<dynamic>? discountDetails;
  bool? isVoid;
  bool? isRefund;
  Data1? data;
  bool? isHidden;
  PaymentKeyClaims? paymentKeyClaims;
  bool? errorOccured;
  bool? isLive;
  dynamic otherEndpointReference;
  int? refundedAmountCents;
  int? sourceId;
  bool? isCaptured;
  int? capturedAmount;
  dynamic merchantStaffTag;
  String? updatedAt;
  bool? isSettled;
  bool? billBalanced;
  bool? isBill;
  int? owner;
  dynamic parentTransaction;

  KioskPaymentResponse({this.id, this.pending, this.amountCents, this.success, this.isAuth, this.isCapture, this.isStandalonePayment, this.isVoided, this.isRefunded, this.is3DSecure, this.integrationId, this.profileId, this.hasParentTransaction, this.order, this.createdAt, this.transactionProcessedCallbackResponses, this.currency, this.sourceData, this.apiSource, this.terminalId, this.merchantCommission, this.acceptFees, this.installment, this.discountDetails, this.isVoid, this.isRefund, this.data, this.isHidden, this.paymentKeyClaims, this.errorOccured, this.isLive, this.otherEndpointReference, this.refundedAmountCents, this.sourceId, this.isCaptured, this.capturedAmount, this.merchantStaffTag, this.updatedAt, this.isSettled, this.billBalanced, this.isBill, this.owner, this.parentTransaction});

  KioskPaymentResponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    pending = json["pending"];
    amountCents = json["amount_cents"];
    success = json["success"];
    isAuth = json["is_auth"];
    isCapture = json["is_capture"];
    isStandalonePayment = json["is_standalone_payment"];
    isVoided = json["is_voided"];
    isRefunded = json["is_refunded"];
    is3DSecure = json["is_3d_secure"];
    integrationId = json["integration_id"];
    profileId = json["profile_id"];
    hasParentTransaction = json["has_parent_transaction"];
    order = json["order"] == null ? null : Order.fromJson(json["order"]);
    createdAt = json["created_at"];
    transactionProcessedCallbackResponses = json["transaction_processed_callback_responses"] ?? [];
    currency = json["currency"];
    sourceData = json["source_data"] == null ? null : SourceData.fromJson(json["source_data"]);
    apiSource = json["api_source"];
    terminalId = json["terminal_id"];
    merchantCommission = json["merchant_commission"];
    acceptFees = json["accept_fees"];
    installment = json["installment"];
    discountDetails = json["discount_details"] ?? [];
    isVoid = json["is_void"];
    isRefund = json["is_refund"];
    data = json["data"] == null ? null : Data1.fromJson(json["data"]);
    isHidden = json["is_hidden"];
    paymentKeyClaims = json["payment_key_claims"] == null ? null : PaymentKeyClaims.fromJson(json["payment_key_claims"]);
    errorOccured = json["error_occured"];
    isLive = json["is_live"];
    otherEndpointReference = json["other_endpoint_reference"];
    refundedAmountCents = json["refunded_amount_cents"];
    sourceId = json["source_id"];
    isCaptured = json["is_captured"];
    capturedAmount = json["captured_amount"];
    merchantStaffTag = json["merchant_staff_tag"];
    updatedAt = json["updated_at"];
    isSettled = json["is_settled"];
    billBalanced = json["bill_balanced"];
    isBill = json["is_bill"];
    owner = json["owner"];
    parentTransaction = json["parent_transaction"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["pending"] = pending;
    _data["amount_cents"] = amountCents;
    _data["success"] = success;
    _data["is_auth"] = isAuth;
    _data["is_capture"] = isCapture;
    _data["is_standalone_payment"] = isStandalonePayment;
    _data["is_voided"] = isVoided;
    _data["is_refunded"] = isRefunded;
    _data["is_3d_secure"] = is3DSecure;
    _data["integration_id"] = integrationId;
    _data["profile_id"] = profileId;
    _data["has_parent_transaction"] = hasParentTransaction;
    if(order != null) {
      _data["order"] = order?.toJson();
    }
    _data["created_at"] = createdAt;
    if(transactionProcessedCallbackResponses != null) {
      _data["transaction_processed_callback_responses"] = transactionProcessedCallbackResponses;
    }
    _data["currency"] = currency;
    if(sourceData != null) {
      _data["source_data"] = sourceData?.toJson();
    }
    _data["api_source"] = apiSource;
    _data["terminal_id"] = terminalId;
    _data["merchant_commission"] = merchantCommission;
    _data["accept_fees"] = acceptFees;
    _data["installment"] = installment;
    if(discountDetails != null) {
      _data["discount_details"] = discountDetails;
    }
    _data["is_void"] = isVoid;
    _data["is_refund"] = isRefund;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    _data["is_hidden"] = isHidden;
    if(paymentKeyClaims != null) {
      _data["payment_key_claims"] = paymentKeyClaims?.toJson();
    }
    _data["error_occured"] = errorOccured;
    _data["is_live"] = isLive;
    _data["other_endpoint_reference"] = otherEndpointReference;
    _data["refunded_amount_cents"] = refundedAmountCents;
    _data["source_id"] = sourceId;
    _data["is_captured"] = isCaptured;
    _data["captured_amount"] = capturedAmount;
    _data["merchant_staff_tag"] = merchantStaffTag;
    _data["updated_at"] = updatedAt;
    _data["is_settled"] = isSettled;
    _data["bill_balanced"] = billBalanced;
    _data["is_bill"] = isBill;
    _data["owner"] = owner;
    _data["parent_transaction"] = parentTransaction;
    return _data;
  }
}

class PaymentKeyClaims {
  int? userId;
  int? amountCents;
  String? currency;
  int? integrationId;
  int? orderId;
  BillingData? billingData;
  bool? lockOrderWhenPaid;
  Extra? extra;
  bool? singlePaymentAttempt;
  String? pmkIp;

  PaymentKeyClaims({this.userId, this.amountCents, this.currency, this.integrationId, this.orderId, this.billingData, this.lockOrderWhenPaid, this.extra, this.singlePaymentAttempt, this.pmkIp});

  PaymentKeyClaims.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"];
    amountCents = json["amount_cents"];
    currency = json["currency"];
    integrationId = json["integration_id"];
    orderId = json["order_id"];
    billingData = json["billing_data"] == null ? null : BillingData.fromJson(json["billing_data"]);
    lockOrderWhenPaid = json["lock_order_when_paid"];
    extra = json["extra"] == null ? null : Extra.fromJson(json["extra"]);
    singlePaymentAttempt = json["single_payment_attempt"];
    pmkIp = json["pmk_ip"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["user_id"] = userId;
    _data["amount_cents"] = amountCents;
    _data["currency"] = currency;
    _data["integration_id"] = integrationId;
    _data["order_id"] = orderId;
    if(billingData != null) {
      _data["billing_data"] = billingData?.toJson();
    }
    _data["lock_order_when_paid"] = lockOrderWhenPaid;
    if(extra != null) {
      _data["extra"] = extra?.toJson();
    }
    _data["single_payment_attempt"] = singlePaymentAttempt;
    _data["pmk_ip"] = pmkIp;
    return _data;
  }
}

class Extra {
  Extra();

  Extra.fromJson(Map<String, dynamic> json) {

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};

    return _data;
  }
}

class BillingData {
  String? firstName;
  String? lastName;
  String? street;
  String? building;
  String? floor;
  String? apartment;
  String? city;
  String? state;
  String? country;
  String? email;
  String? phoneNumber;
  String? postalCode;
  String? extraDescription;

  BillingData({this.firstName, this.lastName, this.street, this.building, this.floor, this.apartment, this.city, this.state, this.country, this.email, this.phoneNumber, this.postalCode, this.extraDescription});

  BillingData.fromJson(Map<String, dynamic> json) {
    firstName = json["first_name"];
    lastName = json["last_name"];
    street = json["street"];
    building = json["building"];
    floor = json["floor"];
    apartment = json["apartment"];
    city = json["city"];
    state = json["state"];
    country = json["country"];
    email = json["email"];
    phoneNumber = json["phone_number"];
    postalCode = json["postal_code"];
    extraDescription = json["extra_description"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["street"] = street;
    _data["building"] = building;
    _data["floor"] = floor;
    _data["apartment"] = apartment;
    _data["city"] = city;
    _data["state"] = state;
    _data["country"] = country;
    _data["email"] = email;
    _data["phone_number"] = phoneNumber;
    _data["postal_code"] = postalCode;
    _data["extra_description"] = extraDescription;
    return _data;
  }
}

class Data1 {
  String? klass;
  int? gatewayIntegrationPk;
  dynamic ref;
  dynamic rrn;
  dynamic amount;
  dynamic fromUser;
  String? message;
  dynamic biller;
  String? txnResponseCode;
  int? billReference;
  dynamic aggTerminal;
  int? dueAmount;
  dynamic cashoutAmount;
  String? paidThrough;
  String? otp;

  Data1({this.klass, this.gatewayIntegrationPk, this.ref, this.rrn, this.amount, this.fromUser, this.message, this.biller, this.txnResponseCode, this.billReference, this.aggTerminal, this.dueAmount, this.cashoutAmount, this.paidThrough, this.otp});

  Data1.fromJson(Map<String, dynamic> json) {
    klass = json["klass"];
    gatewayIntegrationPk = json["gateway_integration_pk"];
    ref = json["ref"];
    rrn = json["rrn"];
    amount = json["amount"];
    fromUser = json["from_user"];
    message = json["message"];
    biller = json["biller"];
    txnResponseCode = json["txn_response_code"];
    billReference = json["bill_reference"];
    aggTerminal = json["agg_terminal"];
    dueAmount = json["due_amount"];
    cashoutAmount = json["cashout_amount"];
    paidThrough = json["paid_through"];
    otp = json["otp"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["klass"] = klass;
    _data["gateway_integration_pk"] = gatewayIntegrationPk;
    _data["ref"] = ref;
    _data["rrn"] = rrn;
    _data["amount"] = amount;
    _data["from_user"] = fromUser;
    _data["message"] = message;
    _data["biller"] = biller;
    _data["txn_response_code"] = txnResponseCode;
    _data["bill_reference"] = billReference;
    _data["agg_terminal"] = aggTerminal;
    _data["due_amount"] = dueAmount;
    _data["cashout_amount"] = cashoutAmount;
    _data["paid_through"] = paidThrough;
    _data["otp"] = otp;
    return _data;
  }
}

class SourceData {
  String? type;
  String? subType;
  String? pan;

  SourceData({this.type, this.subType, this.pan});

  SourceData.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    subType = json["sub_type"];
    pan = json["pan"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    _data["sub_type"] = subType;
    _data["pan"] = pan;
    return _data;
  }
}

class Order {
  int? id;
  String? createdAt;
  bool? deliveryNeeded;
  Merchant? merchant;
  dynamic collector;
  int? amountCents;
  ShippingData? shippingData;
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

  Order({this.id, this.createdAt, this.deliveryNeeded, this.merchant, this.collector, this.amountCents, this.shippingData, this.currency, this.isPaymentLocked, this.isReturn, this.isCancel, this.isReturned, this.isCanceled, this.merchantOrderId, this.walletNotification, this.paidAmountCents, this.notifyUserWithEmail, this.items, this.orderUrl, this.commissionFees, this.deliveryFeesCents, this.deliveryVatCents, this.paymentMethod, this.merchantStaffTag, this.apiSource, this.data, this.paymentStatus, this.terminalVersion});

  Order.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    createdAt = json["created_at"];
    deliveryNeeded = json["delivery_needed"];
    merchant = json["merchant"] == null ? null : Merchant.fromJson(json["merchant"]);
    collector = json["collector"];
    amountCents = json["amount_cents"];
    shippingData = json["shipping_data"] == null ? null : ShippingData.fromJson(json["shipping_data"]);
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
    if(shippingData != null) {
      _data["shipping_data"] = shippingData?.toJson();
    }
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

class ShippingData {
  int? id;
  String? firstName;
  String? lastName;
  String? street;
  String? building;
  String? floor;
  String? apartment;
  String? city;
  String? state;
  String? country;
  String? email;
  String? phoneNumber;
  String? postalCode;
  String? extraDescription;
  String? shippingMethod;
  int? orderId;
  int? order;

  ShippingData({this.id, this.firstName, this.lastName, this.street, this.building, this.floor, this.apartment, this.city, this.state, this.country, this.email, this.phoneNumber, this.postalCode, this.extraDescription, this.shippingMethod, this.orderId, this.order});

  ShippingData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    street = json["street"];
    building = json["building"];
    floor = json["floor"];
    apartment = json["apartment"];
    city = json["city"];
    state = json["state"];
    country = json["country"];
    email = json["email"];
    phoneNumber = json["phone_number"];
    postalCode = json["postal_code"];
    extraDescription = json["extra_description"];
    shippingMethod = json["shipping_method"];
    orderId = json["order_id"];
    order = json["order"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["street"] = street;
    _data["building"] = building;
    _data["floor"] = floor;
    _data["apartment"] = apartment;
    _data["city"] = city;
    _data["state"] = state;
    _data["country"] = country;
    _data["email"] = email;
    _data["phone_number"] = phoneNumber;
    _data["postal_code"] = postalCode;
    _data["extra_description"] = extraDescription;
    _data["shipping_method"] = shippingMethod;
    _data["order_id"] = orderId;
    _data["order"] = order;
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
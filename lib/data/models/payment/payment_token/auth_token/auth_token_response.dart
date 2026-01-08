
class ResponseApiKey{
  Profile? profile;
  String? token;

  ResponseApiKey({this.profile, this.token});

  ResponseApiKey.fromJson(Map<String, dynamic> json) {
    profile = json["profile"] == null ? null : Profile.fromJson(json["profile"]);
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(profile != null) {
      _data["profile"] = profile?.toJson();
    }
    _data["token"] = token;
    return _data;
  }
}

class Profile {
  int? id;
  User? user;
  String? createdAt;
  bool? active;
  String? profileType;
  List<String>? phones;
  dynamic companyEmails;
  String? companyName;
  String? state;
  String? country;
  String? city;
  String? postalCode;
  String? street;
  bool? emailNotification;
  dynamic orderRetrievalEndpoint;
  dynamic deliveryUpdateEndpoint;
  dynamic logoUrl;
  bool? isMobadra;
  String? sector;
  bool? is2FaEnabled;
  String? otpSentTo;
  int? activationMethod;
  int? signedUpThrough;
  int? failedAttempts;
  List<dynamic>? customExportColumns;
  List<dynamic>? serverIp;
  dynamic username;
  String? primaryPhoneNumber;
  bool? primaryPhoneVerified;
  bool? isTempPassword;
  dynamic otp2FaSentAt;
  dynamic otp2FaAttempt;
  String? otpSentAt;
  String? otpValidatedAt;
  dynamic awbBanner;
  dynamic emailBanner;
  dynamic identificationNumber;
  String? deliveryStatusCallback;
  dynamic merchantExternalLink;
  int? merchantStatus;
  bool? deactivatedByBank;
  dynamic bankDeactivationReason;
  int? bankMerchantStatus;
  dynamic nationalId;
  dynamic superAgent;
  dynamic walletLimitProfile;
  dynamic address;
  dynamic commercialRegistration;
  dynamic commercialRegistrationArea;
  dynamic distributorCode;
  dynamic distributorBranchCode;
  bool? allowTerminalOrderId;
  bool? allowEncryptionBypass;
  dynamic walletPhoneNumber;
  int? suspicious;
  dynamic latitude;
  dynamic longitude;
  BankStaffs? bankStaffs;
  dynamic bankRejectionReason;
  bool? bankReceivedDocuments;
  int? bankMerchantDigitalStatus;
  dynamic bankDigitalRejectionReason;
  bool? filledBusinessData;
  String? dayStartTime;
  dynamic dayEndTime;
  bool? withholdTransfers;
  bool? manualSettlement;
  String? smsSenderName;
  dynamic withholdTransfersReason;
  dynamic withholdTransfersNotes;
  bool? canBillDepositWithCard;
  bool? canTopupMerchants;
  dynamic topupTransferId;
  bool? referralEligible;
  bool? isEligibleToBeRanger;
  bool? eligibleForManualRefunds;
  bool? isRanger;
  bool? isPoaching;
  bool? paymobAppMerchant;
  dynamic settlementFrequency;
  dynamic dayOfTheWeek;
  dynamic dayOfTheMonth;
  bool? allowTransactionNotifications;
  bool? allowTransferNotifications;
  double? sallefnyAmountWhole;
  double? sallefnyFeesWhole;
  dynamic paymobAppFirstLogin;
  dynamic paymobAppLastActivity;
  bool? payoutEnabled;
  bool? payoutTerms;
  bool? isBillsNew;
  bool? canProcessMultipleRefunds;
  int? settlementClassification;
  int? vatClassification;
  bool? instantSettlementEnabled;
  bool? instantSettlementTransactionOtpVerified;
  dynamic preferredLanguage;
  bool? ignoreFlashCallbacks;
  bool? receiveCallbackCardInfo;
  dynamic onboardingFreshdeskTicketId;
  bool? paymobEvent;
  dynamic acqPartner;
  dynamic dom;
  dynamic bankRelated;
  List<dynamic>? permissions;

  Profile({this.id, this.user, this.createdAt, this.active, this.profileType, this.phones, this.companyEmails, this.companyName, this.state, this.country, this.city, this.postalCode, this.street, this.emailNotification, this.orderRetrievalEndpoint, this.deliveryUpdateEndpoint, this.logoUrl, this.isMobadra, this.sector, this.is2FaEnabled, this.otpSentTo, this.activationMethod, this.signedUpThrough, this.failedAttempts, this.customExportColumns, this.serverIp, this.username, this.primaryPhoneNumber, this.primaryPhoneVerified, this.isTempPassword, this.otp2FaSentAt, this.otp2FaAttempt, this.otpSentAt, this.otpValidatedAt, this.awbBanner, this.emailBanner, this.identificationNumber, this.deliveryStatusCallback, this.merchantExternalLink, this.merchantStatus, this.deactivatedByBank, this.bankDeactivationReason, this.bankMerchantStatus, this.nationalId, this.superAgent, this.walletLimitProfile, this.address, this.commercialRegistration, this.commercialRegistrationArea, this.distributorCode, this.distributorBranchCode, this.allowTerminalOrderId, this.allowEncryptionBypass, this.walletPhoneNumber, this.suspicious, this.latitude, this.longitude, this.bankStaffs, this.bankRejectionReason, this.bankReceivedDocuments, this.bankMerchantDigitalStatus, this.bankDigitalRejectionReason, this.filledBusinessData, this.dayStartTime, this.dayEndTime, this.withholdTransfers, this.manualSettlement, this.smsSenderName, this.withholdTransfersReason, this.withholdTransfersNotes, this.canBillDepositWithCard, this.canTopupMerchants, this.topupTransferId, this.referralEligible, this.isEligibleToBeRanger, this.eligibleForManualRefunds, this.isRanger, this.isPoaching, this.paymobAppMerchant, this.settlementFrequency, this.dayOfTheWeek, this.dayOfTheMonth, this.allowTransactionNotifications, this.allowTransferNotifications, this.sallefnyAmountWhole, this.sallefnyFeesWhole, this.paymobAppFirstLogin, this.paymobAppLastActivity, this.payoutEnabled, this.payoutTerms, this.isBillsNew, this.canProcessMultipleRefunds, this.settlementClassification, this.vatClassification, this.instantSettlementEnabled, this.instantSettlementTransactionOtpVerified, this.preferredLanguage, this.ignoreFlashCallbacks, this.receiveCallbackCardInfo, this.onboardingFreshdeskTicketId, this.paymobEvent, this.acqPartner, this.dom, this.bankRelated, this.permissions});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    user = json["user"] == null ? null : User.fromJson(json["user"]);
    createdAt = json["created_at"];
    active = json["active"];
    profileType = json["profile_type"];
    phones = json["phones"] == null ? null : List<String>.from(json["phones"]);
    companyEmails = json["company_emails"];
    companyName = json["company_name"];
    state = json["state"];
    country = json["country"];
    city = json["city"];
    postalCode = json["postal_code"];
    street = json["street"];
    emailNotification = json["email_notification"];
    orderRetrievalEndpoint = json["order_retrieval_endpoint"];
    deliveryUpdateEndpoint = json["delivery_update_endpoint"];
    logoUrl = json["logo_url"];
    isMobadra = json["is_mobadra"];
    sector = json["sector"];
    is2FaEnabled = json["is_2fa_enabled"];
    otpSentTo = json["otp_sent_to"];
    activationMethod = json["activation_method"];
    signedUpThrough = json["signed_up_through"];
    failedAttempts = json["failed_attempts"];
    customExportColumns = json["custom_export_columns"] ?? [];
    serverIp = json["server_IP"] ?? [];
    username = json["username"];
    primaryPhoneNumber = json["primary_phone_number"];
    primaryPhoneVerified = json["primary_phone_verified"];
    isTempPassword = json["is_temp_password"];
    otp2FaSentAt = json["otp_2fa_sent_at"];
    otp2FaAttempt = json["otp_2fa_attempt"];
    otpSentAt = json["otp_sent_at"];
    otpValidatedAt = json["otp_validated_at"];
    awbBanner = json["awb_banner"];
    emailBanner = json["email_banner"];
    identificationNumber = json["identification_number"];
    deliveryStatusCallback = json["delivery_status_callback"];
    merchantExternalLink = json["merchant_external_link"];
    merchantStatus = json["merchant_status"];
    deactivatedByBank = json["deactivated_by_bank"];
    bankDeactivationReason = json["bank_deactivation_reason"];
    bankMerchantStatus = json["bank_merchant_status"];
    nationalId = json["national_id"];
    superAgent = json["super_agent"];
    walletLimitProfile = json["wallet_limit_profile"];
    address = json["address"];
    commercialRegistration = json["commercial_registration"];
    commercialRegistrationArea = json["commercial_registration_area"];
    distributorCode = json["distributor_code"];
    distributorBranchCode = json["distributor_branch_code"];
    allowTerminalOrderId = json["allow_terminal_order_id"];
    allowEncryptionBypass = json["allow_encryption_bypass"];
    walletPhoneNumber = json["wallet_phone_number"];
    suspicious = json["suspicious"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    bankStaffs = json["bank_staffs"] == null ? null : BankStaffs.fromJson(json["bank_staffs"]);
    bankRejectionReason = json["bank_rejection_reason"];
    bankReceivedDocuments = json["bank_received_documents"];
    bankMerchantDigitalStatus = json["bank_merchant_digital_status"];
    bankDigitalRejectionReason = json["bank_digital_rejection_reason"];
    filledBusinessData = json["filled_business_data"];
    dayStartTime = json["day_start_time"];
    dayEndTime = json["day_end_time"];
    withholdTransfers = json["withhold_transfers"];
    manualSettlement = json["manual_settlement"];
    smsSenderName = json["sms_sender_name"];
    withholdTransfersReason = json["withhold_transfers_reason"];
    withholdTransfersNotes = json["withhold_transfers_notes"];
    canBillDepositWithCard = json["can_bill_deposit_with_card"];
    canTopupMerchants = json["can_topup_merchants"];
    topupTransferId = json["topup_transfer_id"];
    referralEligible = json["referral_eligible"];
    isEligibleToBeRanger = json["is_eligible_to_be_ranger"];
    eligibleForManualRefunds = json["eligible_for_manual_refunds"];
    isRanger = json["is_ranger"];
    isPoaching = json["is_poaching"];
    paymobAppMerchant = json["paymob_app_merchant"];
    settlementFrequency = json["settlement_frequency"];
    dayOfTheWeek = json["day_of_the_week"];
    dayOfTheMonth = json["day_of_the_month"];
    allowTransactionNotifications = json["allow_transaction_notifications"];
    allowTransferNotifications = json["allow_transfer_notifications"];
    sallefnyAmountWhole = json["sallefny_amount_whole"];
    sallefnyFeesWhole = json["sallefny_fees_whole"];
    paymobAppFirstLogin = json["paymob_app_first_login"];
    paymobAppLastActivity = json["paymob_app_last_activity"];
    payoutEnabled = json["payout_enabled"];
    payoutTerms = json["payout_terms"];
    isBillsNew = json["is_bills_new"];
    canProcessMultipleRefunds = json["can_process_multiple_refunds"];
    settlementClassification = json["settlement_classification"];
    vatClassification = json["vat_classification"];
    instantSettlementEnabled = json["instant_settlement_enabled"];
    instantSettlementTransactionOtpVerified = json["instant_settlement_transaction_otp_verified"];
    preferredLanguage = json["preferred_language"];
    ignoreFlashCallbacks = json["ignore_flash_callbacks"];
    receiveCallbackCardInfo = json["receive_callback_card_info"];
    onboardingFreshdeskTicketId = json["onboarding_freshdesk_ticket_id"];
    paymobEvent = json["paymob_event"];
    acqPartner = json["acq_partner"];
    dom = json["dom"];
    bankRelated = json["bank_related"];
    permissions = json["permissions"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    if(user != null) {
      _data["user"] = user?.toJson();
    }
    _data["created_at"] = createdAt;
    _data["active"] = active;
    _data["profile_type"] = profileType;
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
    _data["email_notification"] = emailNotification;
    _data["order_retrieval_endpoint"] = orderRetrievalEndpoint;
    _data["delivery_update_endpoint"] = deliveryUpdateEndpoint;
    _data["logo_url"] = logoUrl;
    _data["is_mobadra"] = isMobadra;
    _data["sector"] = sector;
    _data["is_2fa_enabled"] = is2FaEnabled;
    _data["otp_sent_to"] = otpSentTo;
    _data["activation_method"] = activationMethod;
    _data["signed_up_through"] = signedUpThrough;
    _data["failed_attempts"] = failedAttempts;
    if(customExportColumns != null) {
      _data["custom_export_columns"] = customExportColumns;
    }
    if(serverIp != null) {
      _data["server_IP"] = serverIp;
    }
    _data["username"] = username;
    _data["primary_phone_number"] = primaryPhoneNumber;
    _data["primary_phone_verified"] = primaryPhoneVerified;
    _data["is_temp_password"] = isTempPassword;
    _data["otp_2fa_sent_at"] = otp2FaSentAt;
    _data["otp_2fa_attempt"] = otp2FaAttempt;
    _data["otp_sent_at"] = otpSentAt;
    _data["otp_validated_at"] = otpValidatedAt;
    _data["awb_banner"] = awbBanner;
    _data["email_banner"] = emailBanner;
    _data["identification_number"] = identificationNumber;
    _data["delivery_status_callback"] = deliveryStatusCallback;
    _data["merchant_external_link"] = merchantExternalLink;
    _data["merchant_status"] = merchantStatus;
    _data["deactivated_by_bank"] = deactivatedByBank;
    _data["bank_deactivation_reason"] = bankDeactivationReason;
    _data["bank_merchant_status"] = bankMerchantStatus;
    _data["national_id"] = nationalId;
    _data["super_agent"] = superAgent;
    _data["wallet_limit_profile"] = walletLimitProfile;
    _data["address"] = address;
    _data["commercial_registration"] = commercialRegistration;
    _data["commercial_registration_area"] = commercialRegistrationArea;
    _data["distributor_code"] = distributorCode;
    _data["distributor_branch_code"] = distributorBranchCode;
    _data["allow_terminal_order_id"] = allowTerminalOrderId;
    _data["allow_encryption_bypass"] = allowEncryptionBypass;
    _data["wallet_phone_number"] = walletPhoneNumber;
    _data["suspicious"] = suspicious;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    if(bankStaffs != null) {
      _data["bank_staffs"] = bankStaffs?.toJson();
    }
    _data["bank_rejection_reason"] = bankRejectionReason;
    _data["bank_received_documents"] = bankReceivedDocuments;
    _data["bank_merchant_digital_status"] = bankMerchantDigitalStatus;
    _data["bank_digital_rejection_reason"] = bankDigitalRejectionReason;
    _data["filled_business_data"] = filledBusinessData;
    _data["day_start_time"] = dayStartTime;
    _data["day_end_time"] = dayEndTime;
    _data["withhold_transfers"] = withholdTransfers;
    _data["manual_settlement"] = manualSettlement;
    _data["sms_sender_name"] = smsSenderName;
    _data["withhold_transfers_reason"] = withholdTransfersReason;
    _data["withhold_transfers_notes"] = withholdTransfersNotes;
    _data["can_bill_deposit_with_card"] = canBillDepositWithCard;
    _data["can_topup_merchants"] = canTopupMerchants;
    _data["topup_transfer_id"] = topupTransferId;
    _data["referral_eligible"] = referralEligible;
    _data["is_eligible_to_be_ranger"] = isEligibleToBeRanger;
    _data["eligible_for_manual_refunds"] = eligibleForManualRefunds;
    _data["is_ranger"] = isRanger;
    _data["is_poaching"] = isPoaching;
    _data["paymob_app_merchant"] = paymobAppMerchant;
    _data["settlement_frequency"] = settlementFrequency;
    _data["day_of_the_week"] = dayOfTheWeek;
    _data["day_of_the_month"] = dayOfTheMonth;
    _data["allow_transaction_notifications"] = allowTransactionNotifications;
    _data["allow_transfer_notifications"] = allowTransferNotifications;
    _data["sallefny_amount_whole"] = sallefnyAmountWhole;
    _data["sallefny_fees_whole"] = sallefnyFeesWhole;
    _data["paymob_app_first_login"] = paymobAppFirstLogin;
    _data["paymob_app_last_activity"] = paymobAppLastActivity;
    _data["payout_enabled"] = payoutEnabled;
    _data["payout_terms"] = payoutTerms;
    _data["is_bills_new"] = isBillsNew;
    _data["can_process_multiple_refunds"] = canProcessMultipleRefunds;
    _data["settlement_classification"] = settlementClassification;
    _data["vat_classification"] = vatClassification;
    _data["instant_settlement_enabled"] = instantSettlementEnabled;
    _data["instant_settlement_transaction_otp_verified"] = instantSettlementTransactionOtpVerified;
    _data["preferred_language"] = preferredLanguage;
    _data["ignore_flash_callbacks"] = ignoreFlashCallbacks;
    _data["receive_callback_card_info"] = receiveCallbackCardInfo;
    _data["onboarding_freshdesk_ticket_id"] = onboardingFreshdeskTicketId;
    _data["paymob_event"] = paymobEvent;
    _data["acq_partner"] = acqPartner;
    _data["dom"] = dom;
    _data["bank_related"] = bankRelated;
    if(permissions != null) {
      _data["permissions"] = permissions;
    }
    return _data;
  }
}

class BankStaffs {
  BankStaffs();

  BankStaffs.fromJson(Map<String, dynamic> json) {

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};

    return _data;
  }
}

class User {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? dateJoined;
  String? email;
  bool? isActive;
  bool? isStaff;
  bool? isSuperuser;
  dynamic lastLogin;
  List<dynamic>? groups;
  List<int>? userPermissions;

  User({this.id, this.username, this.firstName, this.lastName, this.dateJoined, this.email, this.isActive, this.isStaff, this.isSuperuser, this.lastLogin, this.groups, this.userPermissions});

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    username = json["username"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    dateJoined = json["date_joined"];
    email = json["email"];
    isActive = json["is_active"];
    isStaff = json["is_staff"];
    isSuperuser = json["is_superuser"];
    lastLogin = json["last_login"];
    groups = json["groups"] ?? [];
    userPermissions = json["user_permissions"] == null ? null : List<int>.from(json["user_permissions"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["username"] = username;
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["date_joined"] = dateJoined;
    _data["email"] = email;
    _data["is_active"] = isActive;
    _data["is_staff"] = isStaff;
    _data["is_superuser"] = isSuperuser;
    _data["last_login"] = lastLogin;
    if(groups != null) {
      _data["groups"] = groups;
    }
    if(userPermissions != null) {
      _data["user_permissions"] = userPermissions;
    }
    return _data;
  }
}
//https://developers.payulatam.com/latam/es/docs/integrations/api-integration/payments-api-colombia.html

class PayUPaymentRequest {
  String? language;
  String? command;
  Merchant? merchant;
  Transaction? transaction;
  bool? test;

  PayUPaymentRequest({this.language, this.command, this.merchant, this.transaction, this.test});

  PayUPaymentRequest.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    command = json['command'];
    merchant = json['merchant'] != null ? new Merchant.fromJson(json['merchant']) : null;
    transaction = json['transaction'] != null ? new Transaction.fromJson(json['transaction']) : null;
    test = json['test'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['command'] = this.command;
    if (this.merchant != null) {
      data['merchant'] = this.merchant!.toJson();
    }
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.toJson();
    }
    data['test'] = this.test;
    return data;
  }
}

class Merchant {
  String? apiKey;
  String? apiLogin;

  Merchant({this.apiKey, this.apiLogin});

  Merchant.fromJson(Map<String, dynamic> json) {
    apiKey = json['apiKey'];
    apiLogin = json['apiLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiKey'] = this.apiKey;
    data['apiLogin'] = this.apiLogin;
    return data;
  }
}

class Transaction {
  Order? order;
  Payer? payer;
  CreditCard? creditCard;
  String? type;
  String? paymentMethod;
  String? paymentCountry;
  String? deviceSessionId;
  String? ipAddress;
  String? cookie;
  String? userAgent;

  Transaction({this.order, this.payer, this.creditCard, this.type, this.paymentMethod, this.paymentCountry, this.deviceSessionId, this.ipAddress, this.cookie, this.userAgent});

  Transaction.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    payer = json['payer'] != null ? new Payer.fromJson(json['payer']) : null;
    creditCard = json['creditCard'] != null ? new CreditCard.fromJson(json['creditCard']) : null;
    type = json['type'];
    paymentMethod = json['paymentMethod'];
    paymentCountry = json['paymentCountry'];
    deviceSessionId = json['deviceSessionId'];
    ipAddress = json['ipAddress'];
    cookie = json['cookie'];
    userAgent = json['userAgent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.payer != null) {
      data['payer'] = this.payer!.toJson();
    }
    if (this.creditCard != null) {
      data['creditCard'] = this.creditCard!.toJson();
    }
    data['type'] = this.type;
    data['paymentMethod'] = this.paymentMethod;
    data['paymentCountry'] = this.paymentCountry;
    data['deviceSessionId'] = this.deviceSessionId;
    data['ipAddress'] = this.ipAddress;
    data['cookie'] = this.cookie;
    data['userAgent'] = this.userAgent;
    return data;
  }
}

class Order {
  String? accountId;
  String? referenceCode;
  String? description;
  String? language;
  String? signature;
  Buyer? buyer;

  Order({this.accountId, this.referenceCode, this.description, this.language, this.signature, this.buyer});

  Order.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    referenceCode = json['referenceCode'];
    description = json['description'];
    language = json['language'];
    signature = json['signature'];
    buyer = json['buyer'] != null ? new Buyer.fromJson(json['buyer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountId'] = this.accountId;
    data['referenceCode'] = this.referenceCode;
    data['description'] = this.description;
    data['language'] = this.language;
    data['signature'] = this.signature;
    if (this.buyer != null) {
      data['buyer'] = this.buyer!.toJson();
    }
    return data;
  }
}

class Buyer {
  String? fullName;
  String? emailAddress;
  String? contactPhone;
  String? dniNumber;
  ShippingAddress? shippingAddress;

  Buyer({this.fullName, this.emailAddress, this.contactPhone, this.dniNumber, this.shippingAddress});

  Buyer.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    emailAddress = json['emailAddress'];
    contactPhone = json['contactPhone'];
    dniNumber = json['dniNumber'];
    shippingAddress = json['shippingAddress'] != null ? new ShippingAddress.fromJson(json['shippingAddress']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['emailAddress'] = this.emailAddress;
    data['contactPhone'] = this.contactPhone;
    data['dniNumber'] = this.dniNumber;
    if (this.shippingAddress != null) {
      data['shippingAddress'] = this.shippingAddress!.toJson();
    }
    return data;
  }
}

class ShippingAddress {
  String? street1;
  String? city;
  String? state;
  String? country;
  String? postalCode;

  ShippingAddress({this.street1, this.city, this.state, this.country, this.postalCode});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    street1 = json['street1'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postalCode = json['postalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street1'] = this.street1;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['postalCode'] = this.postalCode;
    return data;
  }
}

class Payer {
  String? fullName;
  String? emailAddress;
  String? contactPhone;
  String? dniNumber;
  BillingAddress? billingAddress;

  Payer({this.fullName, this.emailAddress, this.contactPhone, this.dniNumber, this.billingAddress});

  Payer.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    emailAddress = json['emailAddress'];
    contactPhone = json['contactPhone'];
    dniNumber = json['dniNumber'];
    billingAddress = json['billingAddress'] != null ? new BillingAddress.fromJson(json['billingAddress']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['emailAddress'] = this.emailAddress;
    data['contactPhone'] = this.contactPhone;
    data['dniNumber'] = this.dniNumber;
    if (this.billingAddress != null) {
      data['billingAddress'] = this.billingAddress!.toJson();
    }
    return data;
  }
}

class BillingAddress {
  String? street1;
  String? city;
  String? country;

  BillingAddress({this.street1, this.city, this.country});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    street1 = json['street1'];
    city = json['city'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street1'] = this.street1;
    data['city'] = this.city;
    data['country'] = this.country;
    return data;
  }
}

class CreditCard {
  String? number;
  String? securityCode;
  String? expirationDate;

  CreditCard({this.number, this.securityCode, this.expirationDate});

  CreditCard.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    securityCode = json['securityCode'];
    expirationDate = json['expirationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['securityCode'] = this.securityCode;
    data['expirationDate'] = this.expirationDate;
    return data;
  }
}

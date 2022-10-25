class PaymentMethod {
  late String cardNumber;
  late String expiryDate;
  late String cardHolderName;
  late String cvvCode;
  late String address;
  late String country;
  late String state;
  late String city;

  PaymentMethod(
    String expiryDate,
    String cardHolderName,
    String cvvCode,
    String address,
    String country,
    String state,
    String city,
  ) {
    this.cardNumber = cardNumber;
    this.expiryDate = expiryDate;
    this.cardHolderName = cardHolderName;
    this.cvvCode = cvvCode;
    this.address = address;
    this.country = country;
    this.state = state;
    this.city = city;
  }
}

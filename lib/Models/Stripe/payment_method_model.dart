class UserPaymentMethodModel {
  String id;
  String last4;
  String exp;
  String brand;
  bool isActive;
  final visaImagePath = 'assets/icons/payments/visa.svg';
  final masterCardImagePath = 'assets/icons/payments/mastercard.svg';

  UserPaymentMethodModel(
      {required this.id,
      required this.last4,
      required this.exp,
      required this.brand,
      this.isActive = false});

  toggleActive() => isActive ? isActive = false : isActive = true;
}

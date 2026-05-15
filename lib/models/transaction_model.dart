class TransactionModel {
  final String merchantName;
  final double amount;
  final String cardNumber;

  TransactionModel({
    required this.merchantName,
    required this.amount,
    required this.cardNumber,
  });
}

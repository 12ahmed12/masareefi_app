class ExpenseModel {
  final String id;
  final int categoryId;
  final double amount;
  final double convertedAmount;
  final double exchangeRate;
  final String currency;
  final String date;

  ExpenseModel({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.convertedAmount,
    required this.exchangeRate,
    required this.currency,
    required this.date,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'].toString(),
      categoryId: json['category_id'] as int,
      amount: (json['amount'] as num).toDouble(),
      convertedAmount: (json['converted_amount_usd'] as num).toDouble(),
      exchangeRate: (json['exchange_rate'] as num).toDouble(),
      currency: json['currency'],
      date: json['date'],
    );
  }

  static List<ExpenseModel> fromJsonList(List<Map<String, dynamic>> list) {
    return list.map((e) => ExpenseModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'amount': amount.toDouble(),
      'converted_amount_usd': convertedAmount.toDouble(),
      'exchange_rate': exchangeRate.toDouble(),
      'currency': currency.toString(), // force to string
      'date': date.toString(), // force to string
    };
  }

  @override
  String toString() {
    return '''
ExpenseModel {
  id: $id,
  categoryId: $categoryId,
  amount: $amount,
  convertedAmount: $convertedAmount,
  exchangeRate: $exchangeRate,
  currency: $currency,
  date: $date
}''';
  }
}

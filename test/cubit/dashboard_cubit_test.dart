import 'package:flutter_test/flutter_test.dart';
import 'package:masareefi/features/add_expense/data/models/expense_model.dart';

void main() {
  test('ExpenseModel toJson and fromJson round-trip works', () {
    final expense = ExpenseModel(
      id: '1',
      categoryId: 1,
      amount: 100.0,
      convertedAmount: 5.0,
      exchangeRate: 0.05,
      currency: 'EGP',
      date: '2025-05-31T12:00:00.000Z',
    );

    final json = expense.toJson();
    final parsed = ExpenseModel.fromJson(json);

    expect(parsed.id, expense.id);
    expect(parsed.categoryId, expense.categoryId);
    expect(parsed.amount, expense.amount);
    expect(parsed.convertedAmount, expense.convertedAmount);
    expect(parsed.exchangeRate, expense.exchangeRate);
    expect(parsed.currency, expense.currency);
    expect(parsed.date, expense.date);
  });

  test('Handles invalid amount', () {
    final expense = ExpenseModel(
      id: '2',
      categoryId: 1,
      amount: -5.0,
      convertedAmount: 0.0,
      exchangeRate: 0.05,
      currency: 'EGP',
      date: '2025-05-31T12:00:00.000Z',
    );

    expect(expense.amount < 0, true);
  });
}

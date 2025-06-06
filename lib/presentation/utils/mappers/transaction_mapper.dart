import 'package:eling_app/domain/entities/transaction/transaction.dart';

class TransactionMapper {
  static Map<int, Map<String, double>> toMonthlySummaries(
    Map<int, List<TransactionEntity>> monthlyData,
  ) {
    final Map<int, Map<String, double>> monthlySummaries = {};

    monthlyData.forEach((month, transactions) {
      double income = 0;
      double expense = 0;
      double savings = 0;

      for (final transaction in transactions) {
        switch (transaction.type) {
          case TransactionType.income:
            income += transaction.amount;
            break;
          case TransactionType.expense:
            expense += transaction.amount;
            break;
          case TransactionType.savings:
            savings += transaction.amount;
            break;
          case TransactionType.transfer:
            // Skip transfers
            break;
        }
      }

      monthlySummaries[month] = {
        'income': income,
        'expense': expense,
        'savings': savings,
        'netBalance': income - expense + savings,
      };
    });

    return monthlySummaries;
  }

  static Map<String, double> calculateTotals(
    Map<int, Map<String, double>> monthlySummaries,
  ) {
    double totalIncome = 0;
    double totalExpense = 0;
    double totalSavings = 0;
    double totalNetBalance = 0;

    monthlySummaries.forEach((_, data) {
      totalIncome += data['income'] ?? 0;
      totalExpense += data['expense'] ?? 0;
      totalSavings += data['savings'] ?? 0;
      totalNetBalance += data['netBalance'] ?? 0;
    });

    return {
      'income': totalIncome,
      'expense': totalExpense,
      'savings': totalSavings,
      'netBalance': totalNetBalance,
    };
  }
}

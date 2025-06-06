import 'package:eling_app/core/utils/constants/date_constants.dart';
import 'package:eling_app/data/eling_database.dart';
import 'package:eling_app/domain/entities/detail_summary/detail_summary.dart';
import 'package:eling_app/domain/entities/transaction/transaction.dart';
import 'package:eling_app/domain/entities/finance_summary/finance_summary.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TransactionRepository {
  final ElingDatabase _database;

  TransactionRepository({ElingDatabase? database})
    : _database = database ?? ElingDatabase.instance;

  Future<TransactionEntity> createTransaction(
    TransactionEntity transaction,
  ) async {
    final db = await _database.database;

    await db.transaction((txn) async {
      await txn.insert(
        'transactions',
        transaction.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      switch (transaction.type) {
        case TransactionType.income:
          if (transaction.target != null) {
            await _updateAccountBalance(
              txn,
              transaction.target!,
              transaction.amount,
            );
          }
          break;

        case TransactionType.expense:
          if (transaction.source != null) {
            await _updateAccountBalance(
              txn,
              transaction.source!,
              -transaction.amount,
            );
          }
          break;

        case TransactionType.savings:
          if (transaction.source != null) {
            await _updateAccountBalance(
              txn,
              transaction.source!,
              -transaction.amount,
            );
          }

          if (transaction.target != null) {
            await _updateAccountBalance(
              txn,
              transaction.target!,
              transaction.amount,
            );
          }
          break;

        case TransactionType.transfer:
          if (transaction.source != null) {
            await _updateAccountBalance(
              txn,
              transaction.source!,
              -transaction.amount,
            );
          }

          if (transaction.target != null) {
            await _updateAccountBalance(
              txn,
              transaction.target!,
              transaction.amount,
            );
          }
          break;
      }
    });

    return transaction;
  }

  Future<void> _updateAccountBalance(
    Transaction txn,
    String accountId,
    double amount,
  ) async {
    final accountResult = await txn.query(
      'accounts',
      columns: ['id', 'balance'],
      where: 'id = ?',
      whereArgs: [accountId],
    );

    if (accountResult.isNotEmpty) {
      final currentBalance = accountResult.first['balance'] as double? ?? 0.0;
      final newBalance = currentBalance + amount;

      await txn.update(
        'accounts',
        {'balance': newBalance},
        where: 'id = ?',
        whereArgs: [accountId],
      );
    }
  }

  Future<List<TransactionEntity>> getTransactions({
    required int month,
    required int year,
    TransactionType? type,
  }) async {
    final db = await _database.database;

    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0);

    final startDateStr = DateConstants.formatToYYYYMMDD(startDate);
    final endDateStr = DateConstants.formatToYYYYMMDD(endDate);

    String whereClause = 'date BETWEEN ? AND ?';
    List<Object> whereArgs = [startDateStr, endDateStr];

    if (type != null) {
      whereClause += ' AND type = ?';
      whereArgs.add(type.name);
    }

    final transactionsData = await db.query(
      'transactions',
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: 'date DESC',
    );

    return transactionsData
        .map((json) => TransactionEntity.fromJson(json))
        .toList();
  }

  Future<Map<int, List<TransactionEntity>>> getMonthlySummaryForYear(
    int year,
  ) async {
    final db = await _database.database;

    final startDate = DateTime(year, 1, 1);
    final endDate = DateTime(year, 12, 31);

    final startDateStr = DateConstants.formatToYYYYMMDD(startDate);
    final endDateStr = DateConstants.formatToYYYYMMDD(endDate);

    final transactionsData = await db.query(
      'transactions',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [startDateStr, endDateStr],
      orderBy: 'date DESC',
    );

    final transactions =
        transactionsData
            .map((json) => TransactionEntity.fromJson(json))
            .toList();

    final Map<int, List<TransactionEntity>> transactionsByMonth = {};

    for (var transaction in transactions) {
      final month = transaction.date.month;
      transactionsByMonth[month] ??= [];
      transactionsByMonth[month]!.add(transaction);
    }

    return transactionsByMonth;
  }

  Future<FinanceSummaryEntity> getFinanceSummary({
    required int month,
    required int year,
  }) async {
    final transactions = await getTransactions(month: month, year: year);

    double totalIncome = 0;
    double totalExpense = 0;
    double totalSavings = 0;

    final Map<String, DetailSummaryEntity> incomeSummaries = {};
    final Map<String, DetailSummaryEntity> expenseSummaries = {};

    for (var transaction in transactions) {
      switch (transaction.type) {
        case TransactionType.income:
          totalIncome += transaction.amount;
          _addToCategorySummary(incomeSummaries, transaction);
          break;
        case TransactionType.expense:
          totalExpense += transaction.amount;
          _addToCategorySummary(expenseSummaries, transaction);
          break;
        case TransactionType.savings:
          totalSavings += transaction.amount;
          break;
        case TransactionType.transfer:
          break;
      }
    }

    final totalBalance = await getTotalBalance();

    return FinanceSummaryEntity(
      totalBalance: totalBalance,
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      totalSavings: totalSavings,
      incomeSummaries: incomeSummaries.values.toList(),
      expenseSummaries: expenseSummaries.values.toList(),
      month: month,
      year: year,
    );
  }

  void _addToCategorySummary(
    Map<String, DetailSummaryEntity> summaries,
    TransactionEntity transaction,
  ) {
    final category = transaction.category ?? 'Uncategorized';

    if (!summaries.containsKey(category)) {
      summaries[category] = DetailSummaryEntity(
        category: category,
        amount: 0,
        percentage: 0,
      );
    }

    final existing = summaries[category]!;
    summaries[category] = existing.copyWith(
      amount: existing.amount + transaction.amount,
    );
  }

  Future<double> getTotalBalance() async {
    final db = await _database.database;

    final result = await db.rawQuery(
      'SELECT SUM(balance) as total FROM accounts',
    );

    return result.isNotEmpty ? result.first['total'] as double? ?? 0.0 : 0.0;
  }

  Future<DetailSummaryEntity> getCategorySummary({
    required String category,
    required int month,
    required int year,
    required TransactionType type,
  }) async {
    final transactions = await getTransactions(
      month: month,
      year: year,
      type: type,
    );

    final categoryTransactions =
        transactions.where((t) => t.category == category).toList();

    double totalAmount = 0;
    for (var transaction in categoryTransactions) {
      totalAmount += transaction.amount;
    }

    final allTransactions = transactions.where((t) => t.type == type).toList();
    double totalForType = 0;
    for (var transaction in allTransactions) {
      totalForType += transaction.amount;
    }

    final percentage =
        totalForType > 0 ? (totalAmount / totalForType) * 100 : 0;

    return DetailSummaryEntity(
      category: category,
      amount: totalAmount,
      percentage: percentage.toDouble(),
    );
  }

  Future<int> deleteTransaction(String id) async {
    final db = await _database.database;

    // Ambil transaksi yang akan dihapus
    final transactionData = await db.query(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (transactionData.isEmpty) {
      return 0;
    }

    final transaction = TransactionEntity.fromJson(transactionData.first);

    // Update saldo akun terkait sebelum menghapus transaksi
    await db.transaction((txn) async {
      switch (transaction.type) {
        case TransactionType.income:
          if (transaction.target != null) {
            await _updateAccountBalance(
              txn,
              transaction.target!,
              -transaction.amount,
            );
          }
          break;
        case TransactionType.expense:
          if (transaction.source != null) {
            await _updateAccountBalance(
              txn,
              transaction.source!,
              transaction.amount,
            );
          }
          break;
        case TransactionType.savings:
          if (transaction.source != null) {
            await _updateAccountBalance(
              txn,
              transaction.source!,
              transaction.amount,
            );
          }
          if (transaction.target != null) {
            await _updateAccountBalance(
              txn,
              transaction.target!,
              -transaction.amount,
            );
          }
          break;
        case TransactionType.transfer:
          if (transaction.source != null) {
            await _updateAccountBalance(
              txn,
              transaction.source!,
              transaction.amount,
            );
          }
          if (transaction.target != null) {
            await _updateAccountBalance(
              txn,
              transaction.target!,
              -transaction.amount,
            );
          }
          break;
      }

      await txn.delete(
        'transactions',
        where: 'id = ?',
        whereArgs: [id],
      );
    });

    return 1;
  }
}

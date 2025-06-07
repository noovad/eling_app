import 'package:eling/data/repositories/transaction_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionRepositoryProvider = Provider((ref) {
  return TransactionRepository();
});

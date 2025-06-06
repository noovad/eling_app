import 'package:eling_app/data/repositories/transaction_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionRepositoryProvider = Provider((ref) {
  return TransactionRepository();
});
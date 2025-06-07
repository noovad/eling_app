import 'package:eling/data/repositories/transaction_category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionCategoryRepositoryProvider = Provider((ref) {
  return TransactionCategoryRepository();
});

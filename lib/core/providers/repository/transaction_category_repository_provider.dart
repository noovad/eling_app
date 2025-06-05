import 'package:eling_app/data/repositories/transaction_category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_category_repository_provider.g.dart';

@riverpod
TransactionCategoryRepository transactionCategoryRepository(
  Ref ref,
) {
  return TransactionCategoryRepository();
}

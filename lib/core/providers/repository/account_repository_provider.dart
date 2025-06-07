import 'package:eling/data/repositories/account_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_repository_provider.g.dart';

@riverpod
AccountRepository accountRepository(Ref ref) {
  return AccountRepository();
}

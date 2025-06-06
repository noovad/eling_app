import 'package:eling_app/data/repositories/account_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountRepositoryProvider = Provider((ref) {
  return AccountRepository();
});
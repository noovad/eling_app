import 'package:eling/data/repositories/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepositoryProvider = Provider((ref) {
  return CategoryRepository();
});

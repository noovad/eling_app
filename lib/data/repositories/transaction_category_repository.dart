import 'package:eling_app/data/eling_database.dart';
import 'package:eling_app/domain/entities/transaction_category/transaction_category.dart';

class TransactionCategoryRepository {
  final ElingDatabase _database;

  TransactionCategoryRepository({ElingDatabase? database})
    : _database = database ?? ElingDatabase.instance;

  Future<TransactionCategoryEntity> createCategory(
    TransactionCategoryEntity category,
  ) async {
    return _database.create<TransactionCategoryEntity>(
      'transaction_categories',
      category,
      (category) => category.toJson(),
    );
  }

  Future<List<TransactionCategoryEntity>> getCategories() async {
    final db = await _database.database;

    final categoriesData = await db.query('transaction_categories');

    return categoriesData
        .map((json) => TransactionCategoryEntity.fromJson(json))
        .toList();
  }

  Future<int> updateCategory(TransactionCategoryEntity category) async {
    return _database.update(
      'transaction_categories',
      category.toJson(),
      category.id,
    );
  }

  Future<int> deleteCategory(String id) async {
    return _database.delete('transaction_categories', id);
  }
}

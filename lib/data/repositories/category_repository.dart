import 'package:eling_app/data/eling_database.dart';
import 'package:eling_app/data/model/database_constants.dart';
import 'package:eling_app/domain/entities/category/category.dart';

class CategoryRepository {
  final ElingDatabase _database;

  CategoryRepository({ElingDatabase? database})
    : _database = database ?? ElingDatabase.instance;

  Future<CategoryEntity> createCategory(CategoryEntity category) async {
    return _database.create<CategoryEntity>(
      TableNames.categories,
      category,
      (category) => category.toJson(),
    );
  }

  Future<CategoryEntity?> readCategory(String id) async {
    final results = await _database.read(
      TableNames.categories,
      where: '${CategoryFields.id} = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return CategoryEntity.fromJson(results.first);
    } else {
      return null;
    }
  }

  Future<List<CategoryEntity>> readAllCategories({String? type}) async {
    final results = await _database.read(
      TableNames.categories,
      where: type != null ? '${CategoryFields.type} = ?' : null,
      whereArgs: type != null ? [type] : null,
    );
    return results.map((json) => CategoryEntity.fromJson(json)).toList();
  }

  Future<int> updateCategory(CategoryEntity category) async {
    return _database.update(
      TableNames.categories,
      category.toJson(),
      category.id,
    );
  }

  Future<int> deleteCategory(String id) async {
    return _database.delete(TableNames.categories, id);
  }
}

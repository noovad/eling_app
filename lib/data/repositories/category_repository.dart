import 'package:eling/data/eling_database.dart';
import 'package:eling/data/model/database_constants.dart';
import 'package:eling/domain/entities/category/category.dart';

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

  Future<List<CategoryEntity>> readAllCategories({String? type}) async {
    final results = await _database.read(
      TableNames.categories,
      where: type != null ? '${CategoryFields.type} = ?' : null,
      whereArgs: type != null ? [type] : null,
    );
    return results.map((json) => CategoryEntity.fromJson(json)).toList();
  }

  Future<int> deleteCategory(String id) async {
    return _database.delete(TableNames.categories, id);
  }
}

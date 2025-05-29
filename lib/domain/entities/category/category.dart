import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
abstract class CategoryEntity with _$CategoryEntity {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CategoryEntity({
    @Default('') String id,
    @Default('') String name,
    String? type,
  }) = _CategoryEntity;

  factory CategoryEntity.fromJson(Map<String, Object?> json) =>
      _$CategoryEntityFromJson(json);
}

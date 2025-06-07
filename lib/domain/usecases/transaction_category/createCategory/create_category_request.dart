import 'package:eling/domain/entities/transaction_category/transaction_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_category_request.freezed.dart';
part 'create_category_request.g.dart';

@freezed
abstract class CreateCategoryRequest with _$CreateCategoryRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CreateCategoryRequest({
    required TransactionCategoryEntity category,
  }) = _CreateCategoryRequest;

  factory CreateCategoryRequest.fromJson(Map<String, Object?> json) =>
      _$CreateCategoryRequestFromJson(json);
}

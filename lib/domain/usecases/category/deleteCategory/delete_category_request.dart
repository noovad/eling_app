import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_category_request.freezed.dart';
part 'delete_category_request.g.dart';

@freezed
abstract class DeleteCategoryRequest with _$DeleteCategoryRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DeleteCategoryRequest({required String id}) =
      _DeleteCategoryRequest;

  factory DeleteCategoryRequest.fromJson(Map<String, Object?> json) =>
      _$DeleteCategoryRequestFromJson(json);
}
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_categories_request.freezed.dart';
part 'get_categories_request.g.dart';

@freezed
abstract class GetCategoriesRequest with _$GetCategoriesRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GetCategoriesRequest() = _GetCategoriesRequest;

  factory GetCategoriesRequest.fromJson(Map<String, Object?> json) =>
      _$GetCategoriesRequestFromJson(json);
}

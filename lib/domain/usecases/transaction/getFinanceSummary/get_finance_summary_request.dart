import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_finance_summary_request.freezed.dart';
part 'get_finance_summary_request.g.dart';

@freezed
abstract class GetFinanceSummaryRequest with _$GetFinanceSummaryRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GetFinanceSummaryRequest({
    required int month,
    required int year,
  }) = _GetFinanceSummaryRequest;

  factory GetFinanceSummaryRequest.fromJson(Map<String, Object?> json) =>
      _$GetFinanceSummaryRequestFromJson(json);
}

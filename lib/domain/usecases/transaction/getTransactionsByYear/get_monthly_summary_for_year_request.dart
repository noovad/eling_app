import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_monthly_summary_for_year_request.freezed.dart';
part 'get_monthly_summary_for_year_request.g.dart';

@freezed
abstract class GetMonthlySummaryForYearRequest
    with _$GetMonthlySummaryForYearRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GetMonthlySummaryForYearRequest({required int year}) =
      _GetMonthlySummaryForYearRequest;

  factory GetMonthlySummaryForYearRequest.fromJson(Map<String, Object?> json) =>
      _$GetMonthlySummaryForYearRequestFromJson(json);
}

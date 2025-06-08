import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_summary.freezed.dart';
part 'detail_summary.g.dart';

@freezed
class DetailSummaryEntity with _$DetailSummaryEntity {
  const factory DetailSummaryEntity({
    required String name,
    required double amount,
    required double percentage,
  }) = _DetailSummaryEntity;

  factory DetailSummaryEntity.fromJson(Map<String, dynamic> json) =>
      _$DetailSummaryEntityFromJson(json);
}

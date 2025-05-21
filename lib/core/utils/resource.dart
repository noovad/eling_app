import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource.freezed.dart';

@freezed
sealed class Resource<T> with _$Resource<T> {
  const factory Resource.initial() = Intial<T>;
  const factory Resource.loading() = Loading<T>;
  const factory Resource.success(T value) = Success<T>;
  const factory Resource.failure(String message) = Failure;
}

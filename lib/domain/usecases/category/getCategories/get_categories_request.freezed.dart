// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_categories_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GetCategoriesRequest _$GetCategoriesRequestFromJson(Map<String, dynamic> json) {
  return _GetCategoriesRequest.fromJson(json);
}

/// @nodoc
mixin _$GetCategoriesRequest {
  CategoryTypeEnum? get name => throw _privateConstructorUsedError;

  /// Serializes this GetCategoriesRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetCategoriesRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetCategoriesRequestCopyWith<GetCategoriesRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetCategoriesRequestCopyWith<$Res> {
  factory $GetCategoriesRequestCopyWith(
    GetCategoriesRequest value,
    $Res Function(GetCategoriesRequest) then,
  ) = _$GetCategoriesRequestCopyWithImpl<$Res, GetCategoriesRequest>;
  @useResult
  $Res call({CategoryTypeEnum? name});
}

/// @nodoc
class _$GetCategoriesRequestCopyWithImpl<
  $Res,
  $Val extends GetCategoriesRequest
>
    implements $GetCategoriesRequestCopyWith<$Res> {
  _$GetCategoriesRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetCategoriesRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = freezed}) {
    return _then(
      _value.copyWith(
            name:
                freezed == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as CategoryTypeEnum?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GetCategoriesRequestImplCopyWith<$Res>
    implements $GetCategoriesRequestCopyWith<$Res> {
  factory _$$GetCategoriesRequestImplCopyWith(
    _$GetCategoriesRequestImpl value,
    $Res Function(_$GetCategoriesRequestImpl) then,
  ) = __$$GetCategoriesRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CategoryTypeEnum? name});
}

/// @nodoc
class __$$GetCategoriesRequestImplCopyWithImpl<$Res>
    extends _$GetCategoriesRequestCopyWithImpl<$Res, _$GetCategoriesRequestImpl>
    implements _$$GetCategoriesRequestImplCopyWith<$Res> {
  __$$GetCategoriesRequestImplCopyWithImpl(
    _$GetCategoriesRequestImpl _value,
    $Res Function(_$GetCategoriesRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GetCategoriesRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = freezed}) {
    return _then(
      _$GetCategoriesRequestImpl(
        name:
            freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as CategoryTypeEnum?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$GetCategoriesRequestImpl implements _GetCategoriesRequest {
  const _$GetCategoriesRequestImpl({required this.name});

  factory _$GetCategoriesRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetCategoriesRequestImplFromJson(json);

  @override
  final CategoryTypeEnum? name;

  @override
  String toString() {
    return 'GetCategoriesRequest(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCategoriesRequestImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of GetCategoriesRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetCategoriesRequestImplCopyWith<_$GetCategoriesRequestImpl>
  get copyWith =>
      __$$GetCategoriesRequestImplCopyWithImpl<_$GetCategoriesRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GetCategoriesRequestImplToJson(this);
  }
}

abstract class _GetCategoriesRequest implements GetCategoriesRequest {
  const factory _GetCategoriesRequest({required final CategoryTypeEnum? name}) =
      _$GetCategoriesRequestImpl;

  factory _GetCategoriesRequest.fromJson(Map<String, dynamic> json) =
      _$GetCategoriesRequestImpl.fromJson;

  @override
  CategoryTypeEnum? get name;

  /// Create a copy of GetCategoriesRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetCategoriesRequestImplCopyWith<_$GetCategoriesRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

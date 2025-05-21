// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NoteState {
  Resource<List<NoteEntity>> get notes => throw _privateConstructorUsedError;
  Resource<List<String>> get categories => throw _privateConstructorUsedError;
  TitleInput get title => throw _privateConstructorUsedError;
  ContentInput get content => throw _privateConstructorUsedError;
  String? get selectedCategory => throw _privateConstructorUsedError;
  bool? get isValid => throw _privateConstructorUsedError;

  /// Create a copy of NoteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoteStateCopyWith<NoteState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteStateCopyWith<$Res> {
  factory $NoteStateCopyWith(NoteState value, $Res Function(NoteState) then) =
      _$NoteStateCopyWithImpl<$Res, NoteState>;
  @useResult
  $Res call({
    Resource<List<NoteEntity>> notes,
    Resource<List<String>> categories,
    TitleInput title,
    ContentInput content,
    String? selectedCategory,
    bool? isValid,
  });

  $ResourceCopyWith<List<NoteEntity>, $Res> get notes;
  $ResourceCopyWith<List<String>, $Res> get categories;
}

/// @nodoc
class _$NoteStateCopyWithImpl<$Res, $Val extends NoteState>
    implements $NoteStateCopyWith<$Res> {
  _$NoteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notes = null,
    Object? categories = null,
    Object? title = null,
    Object? content = null,
    Object? selectedCategory = freezed,
    Object? isValid = freezed,
  }) {
    return _then(
      _value.copyWith(
            notes:
                null == notes
                    ? _value.notes
                    : notes // ignore: cast_nullable_to_non_nullable
                        as Resource<List<NoteEntity>>,
            categories:
                null == categories
                    ? _value.categories
                    : categories // ignore: cast_nullable_to_non_nullable
                        as Resource<List<String>>,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as TitleInput,
            content:
                null == content
                    ? _value.content
                    : content // ignore: cast_nullable_to_non_nullable
                        as ContentInput,
            selectedCategory:
                freezed == selectedCategory
                    ? _value.selectedCategory
                    : selectedCategory // ignore: cast_nullable_to_non_nullable
                        as String?,
            isValid:
                freezed == isValid
                    ? _value.isValid
                    : isValid // ignore: cast_nullable_to_non_nullable
                        as bool?,
          )
          as $Val,
    );
  }

  /// Create a copy of NoteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResourceCopyWith<List<NoteEntity>, $Res> get notes {
    return $ResourceCopyWith<List<NoteEntity>, $Res>(_value.notes, (value) {
      return _then(_value.copyWith(notes: value) as $Val);
    });
  }

  /// Create a copy of NoteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResourceCopyWith<List<String>, $Res> get categories {
    return $ResourceCopyWith<List<String>, $Res>(_value.categories, (value) {
      return _then(_value.copyWith(categories: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NoteStateImplCopyWith<$Res>
    implements $NoteStateCopyWith<$Res> {
  factory _$$NoteStateImplCopyWith(
    _$NoteStateImpl value,
    $Res Function(_$NoteStateImpl) then,
  ) = __$$NoteStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Resource<List<NoteEntity>> notes,
    Resource<List<String>> categories,
    TitleInput title,
    ContentInput content,
    String? selectedCategory,
    bool? isValid,
  });

  @override
  $ResourceCopyWith<List<NoteEntity>, $Res> get notes;
  @override
  $ResourceCopyWith<List<String>, $Res> get categories;
}

/// @nodoc
class __$$NoteStateImplCopyWithImpl<$Res>
    extends _$NoteStateCopyWithImpl<$Res, _$NoteStateImpl>
    implements _$$NoteStateImplCopyWith<$Res> {
  __$$NoteStateImplCopyWithImpl(
    _$NoteStateImpl _value,
    $Res Function(_$NoteStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NoteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notes = null,
    Object? categories = null,
    Object? title = null,
    Object? content = null,
    Object? selectedCategory = freezed,
    Object? isValid = freezed,
  }) {
    return _then(
      _$NoteStateImpl(
        notes:
            null == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                    as Resource<List<NoteEntity>>,
        categories:
            null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                    as Resource<List<String>>,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as TitleInput,
        content:
            null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                    as ContentInput,
        selectedCategory:
            freezed == selectedCategory
                ? _value.selectedCategory
                : selectedCategory // ignore: cast_nullable_to_non_nullable
                    as String?,
        isValid:
            freezed == isValid
                ? _value.isValid
                : isValid // ignore: cast_nullable_to_non_nullable
                    as bool?,
      ),
    );
  }
}

/// @nodoc

class _$NoteStateImpl with DiagnosticableTreeMixin implements _NoteState {
  const _$NoteStateImpl({
    required this.notes,
    required this.categories,
    this.title = const TitleInput.pure(),
    this.content = const ContentInput.pure(),
    this.selectedCategory,
    this.isValid,
  });

  @override
  final Resource<List<NoteEntity>> notes;
  @override
  final Resource<List<String>> categories;
  @override
  @JsonKey()
  final TitleInput title;
  @override
  @JsonKey()
  final ContentInput content;
  @override
  final String? selectedCategory;
  @override
  final bool? isValid;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NoteState(notes: $notes, categories: $categories, title: $title, content: $content, selectedCategory: $selectedCategory, isValid: $isValid)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NoteState'))
      ..add(DiagnosticsProperty('notes', notes))
      ..add(DiagnosticsProperty('categories', categories))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('selectedCategory', selectedCategory))
      ..add(DiagnosticsProperty('isValid', isValid));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoteStateImpl &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.categories, categories) ||
                other.categories == categories) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    notes,
    categories,
    title,
    content,
    selectedCategory,
    isValid,
  );

  /// Create a copy of NoteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteStateImplCopyWith<_$NoteStateImpl> get copyWith =>
      __$$NoteStateImplCopyWithImpl<_$NoteStateImpl>(this, _$identity);
}

abstract class _NoteState implements NoteState {
  const factory _NoteState({
    required final Resource<List<NoteEntity>> notes,
    required final Resource<List<String>> categories,
    final TitleInput title,
    final ContentInput content,
    final String? selectedCategory,
    final bool? isValid,
  }) = _$NoteStateImpl;

  @override
  Resource<List<NoteEntity>> get notes;
  @override
  Resource<List<String>> get categories;
  @override
  TitleInput get title;
  @override
  ContentInput get content;
  @override
  String? get selectedCategory;
  @override
  bool? get isValid;

  /// Create a copy of NoteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoteStateImplCopyWith<_$NoteStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

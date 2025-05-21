// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoteEntityImpl _$$NoteEntityImplFromJson(Map<String, dynamic> json) =>
    _$NoteEntityImpl(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      category: json['category'] as String? ?? '',
      isPinned: json['is_pinned'] as bool? ?? false,
    );

Map<String, dynamic> _$$NoteEntityImplToJson(_$NoteEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'category': instance.category,
      'is_pinned': instance.isPinned,
    };

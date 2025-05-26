class TableNames {
  static const String tasks = 'tasks';
  static const String notes = 'notes';
  static const String categories = 'categories';
}

class TaskFields {
  static const String id = 'id';
  static const String title = 'title';
  static const String note = 'note';
  static const String date = 'date';
  static const String time = 'time';
  static const String category = 'category';
  static const String isDone = 'is_done';

  static const List<String> values = [
    id,
    title,
    note,
    date,
    time,
    category,
    isDone,
  ];
}

class NoteFields {
  static const String id = 'id';
  static const String title = 'title';
  static const String content = 'content';
  static const String category = 'category';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
  static const String isPinned = 'isPinned';

  static const List<String> values = [
    id,
    title,
    content,
    category,
    createdAt,
    updatedAt,
    isPinned,
  ];
}

class CategoryFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String color = 'color';
  static const String icon = 'icon';
  static const String type = 'type';

  static const List<String> values = [id, name, color, icon, type];
}

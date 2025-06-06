class TableNames {
  static const String tasks = 'tasks';
  static const String recurringTasks = 'recurring_tasks';
  static const String notes = 'notes';
  static const String categories = 'categories';
  static const String transactions = 'transactions';
  static const String accounts = 'accounts';
  static const String transactionCategories = 'transaction_categories';
}

class TaskFields {
  static const String id = 'id';
  static const String title = 'title';
  static const String note = 'note';
  static const String date = 'date';
  static const String time = 'time';
  static const String category = 'category';
  static const String isDone = 'is_done';
  static const String type = 'type';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';

  static const List<String> values = [
    id,
    title,
    note,
    date,
    time,
    category,
    isDone,
    type,
    createdAt,
    updatedAt,
  ];
}

class RecurringTaskFields {
  static const String id = 'id';
  static const String title = 'title';
  static const String note = 'note';
  static const String time = 'time';
  static const String category = 'category';
  static const String type = 'type';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';

  static const List<String> values = [
    id,
    title,
    note,
    time,
    category,
    type,
    createdAt,
    updatedAt,
  ];
}

class NoteFields {
  static const String id = 'id';
  static const String title = 'title';
  static const String content = 'content';
  static const String category = 'category';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String isPinned = 'is_pinned';

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
  static const String type = 'type';

  static const List<String> values = [id, name, type];
}

class TransactionFields {
  static const String id = 'id';
  static const String type = 'type';
  static const String title = 'title';
  static const String date = 'date';
  static const String amount = 'amount';
  static const String category = 'category';
  static const String source = 'source';
  static const String target = 'target';
  static const String description = 'description';

  static const List<String> values = [
    id,
    type,
    title,
    date,
    amount,
    category,
    source,
    target,
    description,
  ];
}

class AccountFields {
  static const String id = 'id';
  static const String type = 'type';
  static const String name = 'name';
  static const String balance = 'balance';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';

  static const List<String> values = [id, type, name, balance, createdAt, updatedAt];
}

class TransactionCategoryFields {
  static const String id = 'id';
  static const String name = 'name';
  
  static const List<String> values = [id, name];
}

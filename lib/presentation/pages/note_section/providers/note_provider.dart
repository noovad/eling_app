import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/presentation/pages/note_section/providers/note_notifier.dart';
import 'package:my_app/presentation/pages/note_section/providers/note_state.dart';

final noteProvider = StateNotifierProvider<NoteNotifier, NoteState>((ref) {
  return NoteNotifier();
});

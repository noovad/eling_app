import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/desktopPages/todoPage/note/note_section.dart';
import 'package:my_app/core/di/providers.dart';
import 'package:my_app/presentation/pages/todo_page/note_section/cubit/note_cubit.dart';
import 'package:my_app/presentation/pages/todo_page/note_section/cubit/note_state.dart';

class NotePage extends ConsumerWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(noteRepositoryProvider);

    return BlocProvider(
      create: (_) => NoteCubit(repository)..loadNotes(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Note Page')),
        body: BlocBuilder<NoteCubit, NoteState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return NoteSection(
              notes: state.notes,
              onSave: (note) => context.read<NoteCubit>().addNote(note),
              onDelete: (note) => context.read<NoteCubit>().deleteNote(note),
              categories: [],
              // titleErrorText: ,
              // contentErrorText: ,
            );
          },
        ),
      ),
    );
  }
}

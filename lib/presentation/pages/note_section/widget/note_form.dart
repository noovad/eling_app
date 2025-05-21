import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';
import 'package:flutter_ui/shared/sizes/app_sizes.dart';
import 'package:flutter_ui/widgets/dropdown/app_dropdown.dart';
import 'package:my_app/presentation/pages/note_section/models/content.dart';
import 'package:my_app/presentation/pages/note_section/models/title.dart';
import 'package:my_app/presentation/pages/note_section/providers/note_provider.dart';

class NoteForm extends ConsumerStatefulWidget {
  const NoteForm({super.key});

  @override
  ConsumerState<NoteForm> createState() => NoteFormState();
}

class NoteFormState extends ConsumerState<NoteForm> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(noteProvider);
    final notifier = ref.read(noteProvider.notifier);
    return Column(
      spacing: AppSizes.dimen16,
      children: [
        AppTextField(
          onChanged: (value) => notifier.titleChanged(value),
          label: 'Title',
          hint: 'Enter note title',
          errorText: state.title.displayError?.getMessage(),
        ),

        AppDropdown(
          label: 'Category',
          items: ['Work', 'Personal', 'Shopping'],
          labelUnselected: 'None',
          onChanged: (value) {
            notifier.categoryChanged(value ?? 'None');
          },
          selected: state.selectedCategory,
        ),

        AppTextField(
          onChanged: (value) => notifier.contentChanged(value),
          minLines: 5,
          maxLines: 10,
          hint: 'Write your note here...',
          label: 'Content',
          errorText: state.content.displayError?.getMessage(),
        ),
      ],
    );
  }
}

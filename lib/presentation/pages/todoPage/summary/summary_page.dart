import 'package:eling_app/presentation/pages/todoPage/summary/provider/summary_provider.dart';
import 'package:eling_app/presentation/pages/todoPage/summary/widget/calender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/widgets/appNav/app_date_nav.dart';

class SummaryPage extends ConsumerWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(summaryProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppDateNav(
            onChange: (newDate) {
              notifier.getDailyActivities(newDate.month, newDate.year);
            },
          ),
          Calender(),
        ],
      ),
    );
  }
}

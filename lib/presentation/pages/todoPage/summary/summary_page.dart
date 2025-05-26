import 'package:eling_app/presentation/pages/todoPage/summary/provider/summary_provider.dart';
import 'package:eling_app/presentation/pages/todoPage/summary/widget/calender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/widgets/appNav/app_date_nav.dart';

class SummaryPage extends ConsumerStatefulWidget {
  const SummaryPage({super.key});

  @override
  ConsumerState<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends ConsumerState<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    final dailyActivites = ref.watch(
      summaryProvider.select((state) => state.dailyActivities),
    );
    final daysInMonth =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
    final startDay =
        DateTime(DateTime.now().year, DateTime.now().month, 1).weekday % 7;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppDateNav(),
          Calender(
            daysInMonth: daysInMonth,
            startDay: startDay,
            date: DateTime.now(),
            data:
                dailyActivites.whenOrNull(
                  success: (dailyActivities) => dailyActivities,
                ) ??
                [],
          ),
        ],
      ),
    );
  }
}

import 'package:eling_app/presentation/pages/todoPage/summary/provider/summary_provider.dart';
import 'package:eling_app/presentation/pages/todoPage/summary/widget/calender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/widgets/appNav/app_month_nav.dart';

class SummaryPage extends ConsumerStatefulWidget {
  const SummaryPage({super.key});

  @override
  ConsumerState<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends ConsumerState<SummaryPage> {
  late final ValueNotifier<DateTime> displayedDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    displayedDate = ValueNotifier<DateTime>(DateTime(now.year, now.month, 1));
  }

  @override
  void dispose() {
    displayedDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dailyActivites = ref.watch(
      summaryProvider.select((state) => state.dailyActivities),
    );
    return ValueListenableBuilder<DateTime>(
      valueListenable: displayedDate,
      builder: (context, date, _) {
        final daysInMonth = DateTime(date.year, date.month + 1, 0).day;
        final startDay = DateTime(date.year, date.month, 1).weekday % 7;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppMonthNav(displayedDate: displayedDate),
              Calender(
                daysInMonth: daysInMonth,
                startDay: startDay,
                date: date,
                data:
                    dailyActivites.whenOrNull(
                      success: (dailyActivities) => dailyActivities,
                    ) ??
                    [],
              ),
            ],
          ),
        );
      },
    );
  }
}

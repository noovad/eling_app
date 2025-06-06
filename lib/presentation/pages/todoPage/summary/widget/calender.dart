import 'package:eling_app/core/providers/notifier/summary_notifier_provider.dart';
import 'package:eling_app/core/providers/notifier/task_notifier_provider.dart';
import 'package:eling_app/core/utils/constants/date_constants.dart';
import 'package:eling_app/presentation/pages/todoPage/task/notifier/task_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/widgets/appCard/app_daily_summary_card.dart';
import 'package:flutter_ui/widgets/appCard/app_daily_summary_shimmer_card.dart';

class Calender extends ConsumerWidget {
  const Calender({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyActivites = ref.watch(
      summaryNotifierProvider.select((state) => state.dailyActivities),
    );
    final date = ref.watch(
      summaryNotifierProvider.select((state) => state.date),
    );
    final notifier = ref.watch(summaryNotifierProvider.notifier);

    final daysInMonth = DateTime(date.year, date.month + 1, 0).day;
    final startDay = DateTime(date.year, date.month, 1).weekday % 7;

    ref.listen<TaskState>(taskNotifierProvider, (prev, next) {
      if (prev?.updateStatusResult != next.updateStatusResult) {
        next.updateStatusResult.whenOrNull(
          success: (_) => notifier.dateChanged(date),
        );
      }
    });

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.0,
      ),
      itemCount: daysInMonth + startDay,
      itemBuilder: (context, index) {
        final isValidDay =
            index >= startDay && (index - startDay + 1) <= daysInMonth;

        if (!isValidDay) return const SizedBox.shrink();

        final dayNumber = index - startDay + 1;
        final isSunday = ((index + 1) % 7) == 0;

        return dailyActivites.when(
          initial: () => const Center(child: AppDailySummaryShimmerCard()),
          loading: () => const Center(child: AppDailySummaryShimmerCard()),
          failure: (message) {
            return Center(child: Text(message));
          },
          success: (dailyActivities) {
            final currentDayActivities =
                dailyActivities
                    .where(
                      (a) =>
                          a.date.day == dayNumber &&
                          a.date.month == date.month &&
                          a.date.year == date.year,
                    )
                    .toList();
            final isToday =
                currentDayActivities.isNotEmpty
                    ? DateConstants.isToday(currentDayActivities.first.date)
                    : false;

            final hasCoding = currentDayActivities.any((a) => a.coding);
            final hasGym = currentDayActivities.any((a) => a.gym);
            final hasCardio = currentDayActivities.any((a) => a.cardio);
            final sholatCount =
                currentDayActivities.isNotEmpty
                    ? currentDayActivities.first.sholat.toString()
                    : "";
            final hasCalorieControlled = currentDayActivities.any(
              (a) => a.calorieControlled,
            );

            return AppDailySummaryCard(
              isToday: isToday,
              sholatCount: sholatCount,
              amount: 0,
              hasCoding: hasCoding,
              hasGym: hasGym,
              hasCardio: hasCardio,
              calorieControlled: hasCalorieControlled,
              isSunday: isSunday,
            );
          },
        );
      },
    );
  }
}

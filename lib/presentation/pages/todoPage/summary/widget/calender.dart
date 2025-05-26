import 'package:eling_app/presentation/pages/todoPage/summary/provider/summary_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/widgets/appCard/app_daily_summary_card.dart';
import 'package:flutter_ui/widgets/appCard/app_daily_summary_shimmer_card.dart';

class Calender extends ConsumerWidget {
  const Calender({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyActivites = ref.watch(
      summaryProvider.select((state) => state.dailyActivities),
    );
    final date = ref.watch(summaryProvider.select((state) => state.date));

    final daysInMonth = DateTime(date.year, date.month + 1, 0).day;
    final startDay = DateTime(date.year, date.month, 1).weekday % 7;

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
            return Text(message);
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

            final hasCoding = currentDayActivities.any((a) => a.coding);
            final hasGym = currentDayActivities.any((a) => a.gym);
            final hasCardio = currentDayActivities.any((a) => a.cardio);
            final amount =
                currentDayActivities.isNotEmpty
                    ? currentDayActivities.first.amount
                    : null;
            final sholatCount =
                currentDayActivities.isNotEmpty
                    ? currentDayActivities.first.sholat.toString()
                    : "";
            final hasCalorieControlled = currentDayActivities.any(
              (a) => a.calorieControlled,
            );

            return AppDailySummaryCard(
              sholatCount: sholatCount,
              amount: amount,
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

import 'package:eling_app/domain/entities/dailyActivity/daily_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/widgets/appCard/app_daily_summary_card.dart';

class Calender extends StatelessWidget {
  final int daysInMonth;
  final int startDay;
  final List<DailyActivityEntity> data;
  final DateTime date;

  const Calender({
    super.key,
    required this.daysInMonth,
    required this.startDay,
    required this.data,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
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

        final currentDayActivities =
            data
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
  }
}

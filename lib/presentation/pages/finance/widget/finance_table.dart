import 'package:eling_app/presentation/pages/finance/widget/monthly_table.dart';
import 'package:eling_app/presentation/pages/finance/widget/yearly_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/widgets/appTabs/app_tabs.dart';

class FinanceTable extends StatelessWidget {
  const FinanceTable({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTabs(
      length: 2,
      tabBar: [Tab(text: 'Monthly'), Tab(text: 'Yearly')],
      tabBarChild: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        shadowColor: Theme.of(context).colorScheme.shadow,

        type: MaterialType.card,
        color: Theme.of(context).colorScheme.primary,
        child: SizedBox.square(
          dimension: 60,
          child: Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      tabBarView: [MonthlyTable(), YearlyTable()],
    );
  }
}

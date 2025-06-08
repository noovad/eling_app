import 'package:eling/core/utils/constants/string_constants.dart';
import 'package:eling/domain/entities/transaction/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';

class DialogDetail extends StatelessWidget {
  final String formattedDate;
  final TransactionEntity transaction;

  const DialogDetail({
    super.key,
    required this.formattedDate,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Transaction Details'),
      content: SizedBox(
        width: 400,
        child: Table(
          columnWidths: const {
            0: IntrinsicColumnWidth(),
            1: FixedColumnWidth(8),
            2: FlexColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          children: [
            _buildTableRow('Date', formattedDate),
            _buildTableRow('Title', transaction.title),
            _buildTableRow('Category', transaction.category ?? '-'),
            _buildTableRow(
              'Amount',
              StringConstants.formatCurrency(transaction.amount),
            ),
            _buildTableRow('Type', transaction.type.name),
            _buildTableRow('Description', transaction.description ?? '-'),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      children: [
        Padding(padding: AppPadding.all8, child: Text(label)),
        Padding(padding: AppPadding.v8, child: Text(':')),
        Padding(padding: AppPadding.all8, child: Text(value, softWrap: true)),
      ],
    );
  }
}

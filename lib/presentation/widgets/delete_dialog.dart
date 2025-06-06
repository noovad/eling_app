import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';

class DeleteDialog extends StatelessWidget {
  final Function()? onDelete;
  final String data;

  const DeleteDialog({super.key, required this.onDelete, this.data = 'Data'});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 100,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text('Are you sure you want to delete this $data'),
              ),
            ),
            AppSpaces.h16,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                AppSpaces.w8,
                ElevatedButton(
                  onPressed: onDelete,
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Tambahkan fungsi ini di bawah kelas DeleteDialog
Future<dynamic> deleteDialog(
  BuildContext context,
  Function()? onDelete,
) {
  return showDialog(
    context: context,
    useRootNavigator: false,
    builder: (context) => DeleteDialog(
      onDelete: onDelete,
    ),
  );
}

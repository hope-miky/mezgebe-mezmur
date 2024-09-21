import 'package:flutter/material.dart';

class AppMenuBtn extends StatelessWidget {
  Map<String, bool> checklistItems = {
    'Item 1': false,
    'Item 2': false,
    'Item 3': false,
    'Item 4': false,
  };

  // This function will show the popup window with checklist.
  void _showChecklistPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Categories'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: checklistItems.keys.map((String key) {
                  return CheckboxListTile(
                    title: Text(key),
                    value: checklistItems[key],
                    onChanged: (bool? value) {
                      setState(() {
                        checklistItems[key] = value!;
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showChecklistPopup(context),
      icon: const Icon(Icons.filter_list),
    );
  }
}

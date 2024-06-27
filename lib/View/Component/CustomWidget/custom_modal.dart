import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomModal {
  showModal({
    required BuildContext context,
  }) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: const Text('設定とプライバシー'),
              leading: const Icon(Icons.settings),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: const Text('アクティビティ'),
              leading: const Icon(Icons.history),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: const Text('アーカイブ'),
              leading: const Icon(Icons.archive),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

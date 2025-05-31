import 'package:flutter/material.dart';

class ReceiptPicker extends StatelessWidget {
  const ReceiptPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("رفع الفاتورة غير مفعّل حالياً")),
        );
      },
      icon: const Icon(Icons.upload_file),
      label: const Text("رفع الفاتورة"),
    );
  }
}

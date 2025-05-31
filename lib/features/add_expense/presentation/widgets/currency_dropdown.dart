import 'package:flutter/material.dart';

class CurrencyDropdown extends StatelessWidget {
  final void Function(String) onChanged;

  const CurrencyDropdown({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: "EGP",
      items: const [
        DropdownMenuItem(value: "EGP", child: Text("جنيه مصري")),
        DropdownMenuItem(value: "USD", child: Text("دولار")),
      ],
      onChanged: (value) => onChanged(value!),
      decoration: const InputDecoration(labelText: "العملة"),
    );
  }
}

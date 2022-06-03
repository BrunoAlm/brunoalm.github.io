import 'package:flutter/material.dart';

class MeuTextFormField extends StatelessWidget {
  const MeuTextFormField(
      {super.key, required this.label, required this.controller, this.largura});
  final String label;
  final TextEditingController controller;
  final double? largura;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        isDense: true,
        label: Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
        constraints: BoxConstraints(maxWidth: largura ?? 220),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(80)),
      ),
    );
  }
}

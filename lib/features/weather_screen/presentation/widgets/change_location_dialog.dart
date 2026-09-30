import 'package:flutter/material.dart';

/// Asks for a city name. Returns it with Navigator.pop(context, city).
class ChangeLocationDialog extends StatefulWidget {
  const ChangeLocationDialog({super.key});

  @override
  State<ChangeLocationDialog> createState() => _ChangeLocationDialogState();
}

class _ChangeLocationDialogState extends State<ChangeLocationDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final city = _controller.text.trim();
    if (city.isNotEmpty) Navigator.pop(context, city);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Location'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        onSubmitted: (_) => _submit(),
        decoration: const InputDecoration(
          hintText: 'City name (e.g. Alexandria, Cairo)',
          prefixIcon: Icon(Icons.location_city),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _submit, child: const Text('Select')),
      ],
    );
  }
}

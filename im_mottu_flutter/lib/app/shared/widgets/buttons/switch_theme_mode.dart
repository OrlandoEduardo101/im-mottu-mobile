import 'package:flutter/material.dart';

class SwitchThemeMode extends StatefulWidget {
  const SwitchThemeMode({super.key, required this.value, required this.onChanged});
  final bool value;
  final void Function(bool value) onChanged;

  @override
  State<SwitchThemeMode> createState() => _SwitchThemeModeState();
}

class _SwitchThemeModeState extends State<SwitchThemeMode> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          widget.onChanged(!widget.value);
        },
        icon: Icon(
          widget.value ? Icons.light_mode : Icons.dark_mode,
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final String? hintText;
  final void Function(String)? onChanged;
  final TextEditingController? textEditingController;

  const CustomSearchField({super.key, this.hintText, this.onChanged, this.textEditingController});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return TextFormField(
      onChanged: onChanged,
      controller: textEditingController,
      decoration: InputDecoration(
        filled: true,
        fillColor: colorScheme.secondaryFixed.withOpacity(0.5),
        prefixIcon: Icon(CupertinoIcons.search, color: colorScheme.onSecondaryFixed),
        hintText: hintText,
        hintStyle: TextStyle(color: colorScheme.onSecondaryFixed),
        suffixIcon: textEditingController?.text != null && textEditingController!.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  textEditingController?.text = '';
                  onChanged?.call('');
                },
                icon: const Icon(Icons.close))
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

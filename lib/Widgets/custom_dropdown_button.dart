import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/language/language_provider.dart';

class CustomDropdownButton extends StatefulWidget {
  final double mWidth;
  const CustomDropdownButton({super.key, this.mWidth = double.infinity});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: widget.mWidth,
      initialSelection:
          context.watch<LanguageProvider>().selectedLocale.languageCode,
      onSelected: (value) {
        context.read<LanguageProvider>().changeLanguage(value.toString());
      },
      dropdownMenuEntries: LanguageProvider.languages
          .map((language) => DropdownMenuEntry(
                value: language['locale'],
                label: language['name'],
              ))
          .toList(),
    );
  }
}

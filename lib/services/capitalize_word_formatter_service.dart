import 'package:flutter/services.dart';

class CapitalizeWordsInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    // Capitalize the first letter of each word
    final capitalizedText = text
        .split(' ')
        .map(
          (word) =>
              word.isNotEmpty
                  ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
                  : '',
        )
        .join(' ');

    // Calculate the new cursor position
    final cursorPosition =
        newValue.selection.baseOffset + (capitalizedText.length - text.length);

    return TextEditingValue(
      text: capitalizedText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}

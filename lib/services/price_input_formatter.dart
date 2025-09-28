import 'package:flutter/services.dart';

class PriceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // If the new value is empty, return it as is
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove any commas from the input
    String newText = newValue.text.replaceAll(',', '');

    // Check if there's more than one decimal point
    if (newText.split('.').length > 2) {
      // If there are multiple decimal points, keep only the first one
      List<String> parts = newText.split('.');
      newText = '${parts[0]}.${parts[1]}';
    }

    // Format the number with commas for thousands
    if (newText.contains('.')) {
      List<String> parts = newText.split('.');
      parts[0] = _formatWithCommas(parts[0]);
      newText = parts.join('.');
    } else {
      newText = _formatWithCommas(newText);
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  String _formatWithCommas(String number) {
    // Remove any existing commas
    number = number.replaceAll(',', '');

    // Add commas for thousands
    final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return number.replaceAllMapped(reg, (Match match) => '${match[1]},');
  }
}

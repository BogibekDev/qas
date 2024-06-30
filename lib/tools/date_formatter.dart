import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue.copyWith(text: '');


    // Remove all non-digits from the input string
    String cleanedText = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Format the cleaned text into dd-mm-yyyy format
    String formattedText = _formatDate(cleanedText);

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatDate(String text) {
    if (text.length < 3) {
      return text;
    } else if (text.length < 5) {
      return '${text.substring(0, 2)}-${text.substring(2)}';
    } else {
      return '${text.substring(0, 2)}-${text.substring(2, 4)}-${text.substring(4, 8)}';
    }
  }
}

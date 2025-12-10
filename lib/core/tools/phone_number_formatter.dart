import 'package:flutter/services.dart';

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any existing spaces from the new input value
    String cleanedText = newValue.text.replaceAll(' ', '');
    final int newTextLength = cleanedText.length;
    int selectionIndex = newValue.selection.end;

    final StringBuffer newText = StringBuffer();
    List<int> splitIndices = [4, 6, 8, 10];

    int usedSubstringIndex = 0;

    for (int i = 0; i < splitIndices.length; i++) {
      if (newTextLength >= splitIndices[i]) {
        newText.write(cleanedText.substring(usedSubstringIndex, usedSubstringIndex = splitIndices[i]));
        if (i < splitIndices.length - 1 && usedSubstringIndex < newTextLength) {
          newText.write(' ');
          if (selectionIndex >= usedSubstringIndex + i) {
            selectionIndex++;
          }
        }
      }
    }

    // Dump the rest
    if (newTextLength >= usedSubstringIndex) {
      newText.write(cleanedText.substring(usedSubstringIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

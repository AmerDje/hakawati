import 'package:flutter/services.dart';

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();

    List<int> splitIndices = [2, 4, 6, 8, 10];

    for (int i = 0; i < splitIndices.length; i++) {
      if (newTextLength >= splitIndices[i]) {
        newText.write(newValue.text.substring(usedSubstringIndex, usedSubstringIndex = splitIndices[i]));
        if (i < splitIndices.length - 1 && newValue.selection.end >= splitIndices[i]) {
          newText.write(' ');
          selectionIndex++;
        }
      }
    }

    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) newText.write(newValue.text.substring(usedSubstringIndex));

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

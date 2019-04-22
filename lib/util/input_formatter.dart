import 'package:flutter/services.dart';

class NumberTextInputFormatter extends TextInputFormatter {
  NumberTextInputFormatter._();

  static NumberTextInputFormatter _instance = NumberTextInputFormatter._();

  static NumberTextInputFormatter getInstance() => _instance;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var iterator = newValue.text.runes.iterator;
    while (iterator.moveNext()) {
      var currentAsString = iterator.currentAsString;
      if (currentAsString.compareTo('0') < 0 ||
          currentAsString.compareTo('9') > 0) {
        return oldValue;
      }
    }
    return newValue;
  }
}

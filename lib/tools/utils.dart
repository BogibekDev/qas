import 'dart:io';

class Utils {
  static bool isDesktop() {
    return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  }
}

extension Price on double {
  String price() {
    var s = toString();
    s = s.substring(0, s.length - 2);
    var result = s[s.length - 1];
    for (int i = 1; i < s.length; i++) {
      if (i % 3 == 0) {
        result = "${s[s.length - i - 1]} $result";
      } else {
        result = s[s.length - i - 1] + result;
      }
    }
    return "$result сўм";
  }

  String priceWithMLN() {
    int result = this ~/ 1000000;
    return "$result млн. сўм";
  }
}

extension Pricee on String {
  String price() {
    return "${addSpace()} сўм";
  }

  String priceWithMLN() {
    double price = double.parse(this);
    int result = price ~/ 1000000;
    return "$result млн. сўм";
  }

  String addSpace() {
    var s = double.parse(this).toStringAsFixed(0);
    var buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) {
        buffer.write(' ');
      }
      buffer.write(s[i]);
    }
    return buffer.toString();
  }

  String removeSpace() {
    String res = this;
    return res.replaceAll(" ", "");
  }
}

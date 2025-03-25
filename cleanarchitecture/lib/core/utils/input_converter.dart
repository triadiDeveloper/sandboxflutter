// # Utility untuk konversi input user

class InputConverter {
  int? stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) return null;
      return integer;
    } catch (e) {
      return null;
    }
  }
}
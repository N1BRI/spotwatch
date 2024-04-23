extension LimitChars on String {
  String limitChars(int maxLength) {
    if (length <= maxLength) {
      return this; // No truncation required if within limit
    } else {
      return '${substring(0, maxLength)}...'; // Truncate to desired length
    }
  }
}

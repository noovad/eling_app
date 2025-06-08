class StringConstants {
  static String capitalizeEachWord(String input) {
    if (input.isEmpty) return input;

    return input
        .split(' ')
        .map(
          (word) =>
              word.isEmpty
                  ? ''
                  : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
        )
        .join(' ');
  }

  static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  static String formatCurrency(double amount) {
    final formattedAmount = amount
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
    return formattedAmount;
  }

  static String shortCurrency(double amount) {
    if (amount < 1000) {
      return amount.toStringAsFixed(0);
    }
    int truncated = (amount / 1000).floor();
    return '$truncated';
  }

  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  static String removeSpecialCharacters(String input) {
    return input.replaceAll(RegExp(r'[^\w\s]+'), '');
  }

  static bool isNumeric(String input) {
    return RegExp(r'^[0-9]+$').hasMatch(input);
  }

  static String slugify(String text) {
    final slug = text
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'[^\w-]+'), '');
    return slug;
  }

  static double parseCurrencyToDouble(String input) {
    String sanitized = input
        .replaceAll('.', '')
        .replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(sanitized) ?? 0.0;
  }

  static const List<String> monthNames = [
    '', // 0-indexed adjustment
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
}

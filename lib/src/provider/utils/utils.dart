class TonApiUtils {
  /// Extracts path parameters from a given URL string.
  ///
  /// This method identifies parameters in the URL enclosed in `{}` and returns
  /// them as a list of strings.
  static List<String> extractParams(String url) {
    final regExp = RegExp(r'\{([^}]+)\}');
    final Iterable<Match> matches = regExp.allMatches(url);
    final List<String> params = [];
    for (final Match match in matches) {
      params.add(match.group(0)!);
    }
    return List<String>.unmodifiable(params);
  }
}

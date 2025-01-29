import 'package:ton_dart/src/exception/exception.dart';

/// Exception thrown for errors related to the Binary Object Container (BOC) operations.
///
/// This class extends `TonDartPluginException` to handle exceptions specific to BOC parsing
/// and manipulation. It allows for custom error messages and additional details.
class BocException extends TonDartPluginException {
  /// Creates a new instance of `BocException`.
  ///
  /// [message] is the error message describing the exception.
  /// [details] is an optional map of additional details to include with the exception.
  BocException(super.message, {super.details});
}

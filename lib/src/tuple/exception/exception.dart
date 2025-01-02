import 'package:ton_dart/src/exception/exception.dart';

/// Exception class for errors related to tuple processing.
class TupleException extends TonDartPluginException {
  /// Creates a new instance of TupleException.
  ///
  /// [message] - The error message associated with the exception.
  /// [details] - Optional additional details about the error. This can include any context-specific information.
  TupleException(super.message, {super.details});
}

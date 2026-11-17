// VM entry: full `ton_dart` suite on the Dart VM.
// Backend via environment (see test/test_backend.dart):
//   BU_BACKEND=dart dart test test/one_shot_test.dart
//   BU_BACKEND=ffi [BU_LIB_PATH=...] [BU_FFI_PROFILE=release] [BU_BUILD=ffi] dart test test/one_shot_test.dart
import 'one_shot_suite.dart';
import 'utils.dart';

void main() async {
  // Builds the FFI library with cargo first when BU_BUILD=ffi|all|1.
  await TonTestApi.ensureBackend();
  await runOneShotSuite();
}

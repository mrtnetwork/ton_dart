import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class AccountStatusChange extends TonSerialization {
  final String status;
  const AccountStatusChange._(this.status);

  // Predefined constant for 'unchanged' account status change.
  static const AccountStatusChange unchanged =
      AccountStatusChange._('unchanged');

  // Predefined constant for 'deleted' account status change.
  static const AccountStatusChange deleted = AccountStatusChange._('deleted');

  // Predefined constant for 'frozen' account status change.
  static const AccountStatusChange frozen = AccountStatusChange._('frozen');

  factory AccountStatusChange.deserialize(Slice slice) {
    if (!slice.loadBit()) return unchanged;
    if (slice.loadBit()) return deleted;
    return frozen;
  }
  factory AccountStatusChange.fromJson(Map<String, dynamic> json) {
    return AccountStatusChange.fromValue(json['status']);
  }

  static const List<AccountStatusChange> values = [unchanged, deleted, frozen];
  factory AccountStatusChange.fromValue(String? status) {
    return values.firstWhere(
      (element) => element.status == status,
      orElse: () => throw TonDartPluginException(
          'Cannot find AccountStatusChange from provided status',
          details: {'status': status}),
    );
  }

  @override
  String toString() {
    return 'AccountStatusChange.$status';
  }

  @override
  void store(Builder builder) {
    switch (this) {
      case AccountStatusChange.unchanged:
        builder.storeBit(0);
        break;
      case AccountStatusChange.deleted:
        builder.storeBit(1);
        builder.storeBit(1);
        break;
      default:
        builder.storeBit(1);
        builder.storeBit(0);
        break;
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {'status': status};
  }
}

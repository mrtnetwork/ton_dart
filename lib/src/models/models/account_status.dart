import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class AccountStatus extends TonSerialization {
  final int tag;
  final String status;
  const AccountStatus._(this.tag, this.status);
  static const AccountStatus uninitialized =
      AccountStatus._(0x00, 'uninitialized');
  static const AccountStatus frozen = AccountStatus._(0x01, 'frozen');
  static const AccountStatus active = AccountStatus._(0x02, 'active');
  static const AccountStatus nonExisting =
      AccountStatus._(0x03, 'non-existing');

  factory AccountStatus.deserialize(Slice slice) {
    return AccountStatus.fromTag(slice.loadUint(2));
  }
  factory AccountStatus.fromJson(Map<String, dynamic> json) {
    return AccountStatus.fromValue(json['status']);
  }

  static const List<AccountStatus> values = [
    uninitialized,
    frozen,
    active,
    nonExisting
  ];
  factory AccountStatus.fromValue(String? status) {
    return values.firstWhere(
      (element) => element.status == status,
      orElse: () => throw TonDartPluginException(
          'Cannot find AccountStatus from provided status',
          details: {'status': status}),
    );
  }
  factory AccountStatus.fromTag(int? tag) {
    return values.firstWhere(
      (element) => element.tag == tag,
      orElse: () => throw TonDartPluginException(
          'Cannot find AccountStatus from provided tag',
          details: {'tag': tag}),
    );
  }

  @override
  void store(Builder builder) {
    builder.storeUint(tag, 2);
  }

  bool get isActive => this != AccountStatus.uninitialized;

  @override
  Map<String, dynamic> toJson() {
    return {'status': status};
  }

  @override
  String toString() {
    return 'AccountStatus.$status';
  }
}

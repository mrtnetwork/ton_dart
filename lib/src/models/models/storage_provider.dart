class StorageProvider {
  final String address;
  final bool acceptNewContracts;
  final int ratePerMBDay;
  final int maxSpan;
  final int minimalFileSize;
  final int maximalFileSize;

  const StorageProvider({
    required this.address,
    required this.acceptNewContracts,
    required this.ratePerMBDay,
    required this.maxSpan,
    required this.minimalFileSize,
    required this.maximalFileSize,
  });

  factory StorageProvider.fromJson(Map<String, dynamic> json) {
    return StorageProvider(
      address: json['address'],
      acceptNewContracts: json['accept_new_contracts'],
      ratePerMBDay: json['rate_per_mb_day'],
      maxSpan: json['max_span'],
      minimalFileSize: json['minimal_file_size'],
      maximalFileSize: json['maximal_file_size'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'address': address,
      'accept_new_contracts': acceptNewContracts,
      'rate_per_mb_day': ratePerMBDay,
      'max_span': maxSpan,
      'minimal_file_size': minimalFileSize,
      'maximal_file_size': maximalFileSize,
    };
    return data;
  }
}

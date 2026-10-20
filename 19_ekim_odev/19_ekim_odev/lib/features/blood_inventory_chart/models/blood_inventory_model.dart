/// Bir kan grubuna ait stok bilgilerini temsil eden değişmez (immutable) veri modeli.
class BloodGroupStock {
  final String bloodType;
  final int currentUnits;
  final int targetUnits;
  final int minSafeUnits;
  final String lastUpdated;

  const BloodGroupStock({
    required this.bloodType,
    required this.currentUnits,
    this.targetUnits = 100,
    this.minSafeUnits = 25,
    required this.lastUpdated,
  });

  /// Doluluk oranı (0.0 ile 1.0 arası)
  double get fillRatio =>
      targetUnits > 0 ? (currentUnits / targetUnits).clamp(0.0, 1.0) : 0.0;

  /// Yüzdelik gösterim (örn: 75)
  int get percentage => (fillRatio * 100).toInt();

  /// Kritik stok seviyesi kontrolü (< minSafeUnits)
  bool get isCritical => currentUnits < minSafeUnits;

  /// Dikkat/Uyarı stok seviyesi kontrolü (minSafeUnits ile %50 arası)
  bool get isWarning =>
      currentUnits >= minSafeUnits && currentUnits < (targetUnits * 0.5);

  /// İdeal ve güvenli seviye kontrolü (>= %50)
  bool get isOptimal => currentUnits >= (targetUnits * 0.5);

  BloodGroupStock copyWith({
    String? bloodType,
    int? currentUnits,
    int? targetUnits,
    int? minSafeUnits,
    String? lastUpdated,
  }) {
    return BloodGroupStock(
      bloodType: bloodType ?? this.bloodType,
      currentUnits: currentUnits ?? this.currentUnits,
      targetUnits: targetUnits ?? this.targetUnits,
      minSafeUnits: minSafeUnits ?? this.minSafeUnits,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  factory BloodGroupStock.fromJson(Map<String, dynamic> json) {
    return BloodGroupStock(
      bloodType: json['bloodType'] as String? ?? '',
      currentUnits: json['currentUnits'] as int? ?? 0,
      targetUnits: json['targetUnits'] as int? ?? 100,
      minSafeUnits: json['minSafeUnits'] as int? ?? 25,
      lastUpdated: json['lastUpdated'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bloodType': bloodType,
      'currentUnits': currentUnits,
      'targetUnits': targetUnits,
      'minSafeUnits': minSafeUnits,
      'lastUpdated': lastUpdated,
    };
  }
}

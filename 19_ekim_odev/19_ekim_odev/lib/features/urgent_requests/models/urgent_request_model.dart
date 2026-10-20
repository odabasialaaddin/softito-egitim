/// Acil kan talebi verilerini temsil eden değişmez (immutable) model.
class UrgentRequest {
  final String id;
  final String patientName;
  final String hospitalName;
  final String city;
  final String bloodType;
  final int requiredUnits;
  final int fulfilledUnits;
  final bool isUrgent;
  final String createdAt;
  final String notes;

  const UrgentRequest({
    required this.id,
    required this.patientName,
    required this.hospitalName,
    required this.city,
    required this.bloodType,
    required this.requiredUnits,
    required this.fulfilledUnits,
    this.isUrgent = true,
    required this.createdAt,
    this.notes = '',
  });

  /// Talebin tamamlanıp tamamlanmadığı
  bool get isCompleted => fulfilledUnits >= requiredUnits;

  /// Kalan ünite sayısı
  int get remainingUnits =>
      (requiredUnits - fulfilledUnits).clamp(0, requiredUnits);

  /// Karşılanma oranı (0.0 - 1.0)
  double get fillRatio =>
      requiredUnits > 0 ? (fulfilledUnits / requiredUnits).clamp(0.0, 1.0) : 0.0;

  UrgentRequest copyWith({
    String? id,
    String? patientName,
    String? hospitalName,
    String? city,
    String? bloodType,
    int? requiredUnits,
    int? fulfilledUnits,
    bool? isUrgent,
    String? createdAt,
    String? notes,
  }) {
    return UrgentRequest(
      id: id ?? this.id,
      patientName: patientName ?? this.patientName,
      hospitalName: hospitalName ?? this.hospitalName,
      city: city ?? this.city,
      bloodType: bloodType ?? this.bloodType,
      requiredUnits: requiredUnits ?? this.requiredUnits,
      fulfilledUnits: fulfilledUnits ?? this.fulfilledUnits,
      isUrgent: isUrgent ?? this.isUrgent,
      createdAt: createdAt ?? this.createdAt,
      notes: notes ?? this.notes,
    );
  }

  factory UrgentRequest.fromJson(Map<String, dynamic> json) {
    return UrgentRequest(
      id: json['id'] as String? ?? '',
      patientName: json['patientName'] as String? ?? '',
      hospitalName: json['hospitalName'] as String? ?? '',
      city: json['city'] as String? ?? '',
      bloodType: json['bloodType'] as String? ?? '',
      requiredUnits: json['requiredUnits'] as int? ?? 1,
      fulfilledUnits: json['fulfilledUnits'] as int? ?? 0,
      isUrgent: json['isUrgent'] as bool? ?? true,
      createdAt: json['createdAt'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientName': patientName,
      'hospitalName': hospitalName,
      'city': city,
      'bloodType': bloodType,
      'requiredUnits': requiredUnits,
      'fulfilledUnits': fulfilledUnits,
      'isUrgent': isUrgent,
      'createdAt': createdAt,
      'notes': notes,
    };
  }
}

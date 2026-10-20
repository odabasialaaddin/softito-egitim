/// Bağışçı profil bilgilerini tutan değişmez (immutable) veri modeli.
class DonorProfile {
  final String name;
  final String bloodType;
  final String profileImage;
  final int donationCount;
  final int healthPoints;
  final String lastDonationDate;
  final String nextEligibleDate;

  const DonorProfile({
    required this.name,
    required this.bloodType,
    required this.profileImage,
    required this.donationCount,
    required this.healthPoints,
    required this.lastDonationDate,
    required this.nextEligibleDate,
  });

  DonorProfile copyWith({
    String? name,
    String? bloodType,
    String? profileImage,
    int? donationCount,
    int? healthPoints,
    String? lastDonationDate,
    String? nextEligibleDate,
  }) {
    return DonorProfile(
      name: name ?? this.name,
      bloodType: bloodType ?? this.bloodType,
      profileImage: profileImage ?? this.profileImage,
      donationCount: donationCount ?? this.donationCount,
      healthPoints: healthPoints ?? this.healthPoints,
      lastDonationDate: lastDonationDate ?? this.lastDonationDate,
      nextEligibleDate: nextEligibleDate ?? this.nextEligibleDate,
    );
  }

  factory DonorProfile.fromJson(Map<String, dynamic> json) {
    return DonorProfile(
      name: json['name'] as String? ?? '',
      bloodType: json['bloodType'] as String? ?? '',
      profileImage: json['profileImage'] as String? ?? '',
      donationCount: json['donationCount'] as int? ?? 0,
      healthPoints: json['healthPoints'] as int? ?? 0,
      lastDonationDate: json['lastDonationDate'] as String? ?? '',
      nextEligibleDate: json['nextEligibleDate'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bloodType': bloodType,
      'profileImage': profileImage,
      'donationCount': donationCount,
      'healthPoints': healthPoints,
      'lastDonationDate': lastDonationDate,
      'nextEligibleDate': nextEligibleDate,
    };
  }
}

/// Yapılan bireysel kan bağışı kaydı modeli.
class DonationRecord {
  final String id;
  final String date;
  final int units;
  final String location;
  final String bloodType;

  const DonationRecord({
    required this.id,
    required this.date,
    required this.units,
    required this.location,
    required this.bloodType,
  });

  DonationRecord copyWith({
    String? id,
    String? date,
    int? units,
    String? location,
    String? bloodType,
  }) {
    return DonationRecord(
      id: id ?? this.id,
      date: date ?? this.date,
      units: units ?? this.units,
      location: location ?? this.location,
      bloodType: bloodType ?? this.bloodType,
    );
  }

  factory DonationRecord.fromJson(Map<String, dynamic> json) {
    return DonationRecord(
      id: json['id'] as String? ?? '',
      date: json['date'] as String? ?? '',
      units: json['units'] as int? ?? 1,
      location: json['location'] as String? ?? '',
      bloodType: json['bloodType'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'units': units,
      'location': location,
      'bloodType': bloodType,
    };
  }
}

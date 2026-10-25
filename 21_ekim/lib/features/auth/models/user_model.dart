enum UserRole {
  teacher,
  student;

  String get displayName {
    switch (this) {
      case UserRole.teacher:
        return 'Öğretmen';
      case UserRole.student:
        return 'Öğrenci';
    }
  }

  bool get isTeacher => this == UserRole.teacher;
  bool get isStudent => this == UserRole.student;

  static UserRole fromString(String role) {
    if (role.toLowerCase() == 'teacher' || role.toLowerCase() == 'öğretmen') {
      return UserRole.teacher;
    }
    return UserRole.student;
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final UserRole role;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    UserRole? role,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      role: UserRole.fromString(json['role'] as String? ?? 'student'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.name,
    };
  }

  bool get isTeacher => role.isTeacher;
  bool get isStudent => role.isStudent;
}

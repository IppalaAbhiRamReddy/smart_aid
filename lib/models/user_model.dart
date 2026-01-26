class UserPreferences {
  final String language;
  final double fontSize;
  final bool darkMode;
  final bool notifications;

  UserPreferences({
    this.language = 'en',
    this.fontSize = 1.0,
    this.darkMode = false,
    this.notifications = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'fontSize': fontSize,
      'darkMode': darkMode,
      'notifications': notifications,
    };
  }

  factory UserPreferences.fromMap(Map<String, dynamic> map) {
    return UserPreferences(
      language: map['language'] ?? 'en',
      fontSize: (map['fontSize'] ?? 1.0).toDouble(),
      darkMode: map['darkMode'] ?? false,
      notifications: map['notifications'] ?? true,
    );
  }
}

class EmergencyContact {
  final String id;
  final String name;
  final String phone;

  EmergencyContact({required this.id, required this.name, required this.phone});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'phone': phone};
  }

  factory EmergencyContact.fromMap(Map<String, dynamic> map) {
    return EmergencyContact(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
    );
  }
}

class UserModel {
  final String id;
  final String name;
  final int age;
  final String phone;
  final String? email;
  final String? photoUrl;
  final String? bloodGroup;
  final String? medicalConditions; // Comma separated or simple strings for now
  final String? allergies;
  final List<EmergencyContact> emergencyContacts;
  final DateTime? memberSince;
  final UserPreferences preferences;

  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.phone,
    this.email,
    this.photoUrl,
    this.bloodGroup,
    this.medicalConditions,
    this.allergies,
    this.emergencyContacts = const [],
    this.memberSince,
    UserPreferences? preferences,
  }) : preferences = preferences ?? UserPreferences();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'phone': phone,
      'email': email,
      'photoUrl': photoUrl,
      'bloodGroup': bloodGroup,
      'medicalConditions': medicalConditions,
      'allergies': allergies,
      'emergencyContacts': emergencyContacts.map((x) => x.toMap()).toList(),
      'memberSince': memberSince?.toIso8601String(),
      'preferences': preferences.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      age: map['age']?.toInt() ?? 0,
      phone: map['phone'] ?? '',
      email: map['email'],
      photoUrl: map['photoUrl'],
      bloodGroup: map['bloodGroup'],
      medicalConditions: map['medicalConditions'],
      allergies: map['allergies'],
      emergencyContacts: List<EmergencyContact>.from(
        (map['emergencyContacts'] ?? []).map(
          (x) => EmergencyContact.fromMap(x),
        ),
      ),
      memberSince: map['memberSince'] != null
          ? DateTime.parse(map['memberSince'])
          : null,
      preferences: map['preferences'] != null
          ? UserPreferences.fromMap(map['preferences'])
          : UserPreferences(),
    );
  }
}

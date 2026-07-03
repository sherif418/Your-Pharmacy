// user.dart
// Responsible for: the domain model that represents an authenticated user.
// Used across the entire app — always read from AuthBloc state.

class AppUser {
  final String uid;
  final String email;
  final String name;
  final String phone;
  final String role;
  final String village;

  const AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
    required this.role,
    required this.village,
  });

  factory AppUser.fromMap(Map<String, dynamic> data, String uid) {
    return AppUser(
      uid: uid,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      role: data['role'] ?? 'customer',
      village: data['village'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'email': email,
        'name': name,
        'phone': phone,
        'role': role,
        'village': village,
      };
}

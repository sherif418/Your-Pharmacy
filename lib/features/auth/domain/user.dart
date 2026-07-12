// user.dart
// Responsible for: the domain model that represents an authenticated user.
// Used across the entire app — always read from AuthBloc state.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  factory AppUser.fromFirebaseUser(User user) {
    return AppUser(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      phone: user.phoneNumber ?? '',
      role: 'customer',
      village: '',
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'email': email,
        'name': name,
        'phone': phone,
        'role': role,
        'village': village,
        'isActive': true,
        'isVerified': true,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
}

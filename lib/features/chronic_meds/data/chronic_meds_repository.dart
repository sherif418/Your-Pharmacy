// chronic_meds_repository.dart
// Responsible for: all Firestore operations related to chronic medications.
// Currently contains placeholder concrete implementations.

class ChronicMedsRepository {
  // ── Load ──────────────────────────────────────────────────
  /// Returns all chronic medications saved for the given [customerId].
  Future<List<Map<String, String>>> getMeds(String customerId) async {
    return [];
  }

  // ── Add ───────────────────────────────────────────────────
  /// Saves a new chronic medication entry.
  Future<void> addMed({
    required String customerId,
    required String medicineName,
    required String dose,
  }) async {
    // Stub implementation
  }

  // ── Delete ────────────────────────────────────────────────
  /// Deletes a chronic medication document.
  Future<void> deleteMed(String medId) async {
    // Stub implementation
  }
}

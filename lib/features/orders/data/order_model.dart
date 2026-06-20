// order_model.dart
// Responsible for: representing a single order's data structure throughout the app.
// Used by OrdersRepository and OrdersBloc — never build this map manually elsewhere.

class OrderModel {
  final String id;
  final String customerId;
  final String customerName;
  final String medicineNames;  // comma-separated list of medicines
  final String? prescriptionUrl; // Firebase Storage URL, null for typed orders
  final String status; // 'pending' | 'preparing' | 'ready' | 'delivered' | 'cancelled'
  final DateTime createdAt;
  final String? notes;

  const OrderModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.medicineNames,
    this.prescriptionUrl,
    required this.status,
    required this.createdAt,
    this.notes,
  });

  // ── Firestore Conversion ───────────────────────────────────
  factory OrderModel.fromMap(Map<String, dynamic> data, String id) {
    return OrderModel(
      id: id,
      customerId: data['customerId'] ?? '',
      customerName: data['customerName'] ?? '',
      medicineNames: data['medicineNames'] ?? '',
      prescriptionUrl: data['prescriptionUrl'],
      status: data['status'] ?? 'pending',
      createdAt: DateTime.parse(data['createdAt'] ?? DateTime.now().toIso8601String()),
      notes: data['notes'],
    );
  }

  Map<String, dynamic> toMap() => {
        'customerId': customerId,
        'customerName': customerName,
        'medicineNames': medicineNames,
        'prescriptionUrl': prescriptionUrl,
        'status': status,
        'createdAt': createdAt.toIso8601String(),
        'notes': notes,
      };
}

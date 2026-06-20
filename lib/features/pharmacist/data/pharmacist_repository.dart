// pharmacist_repository.dart
// Responsible for: pharmacist-specific data actions (viewing all orders, updates).
// Currently contains placeholder concrete implementations.

import 'package:flutter_application_1/features/orders/data/order_model.dart';
import 'package:flutter_application_1/features/auth/domain/user.dart';

class PharmacistRepository {
  // ── Orders ────────────────────────────────────────────────
  /// Fetches all active and past orders.
  Future<List<OrderModel>> getAllOrders() async {
    return [];
  }

  /// Updates the status of a specific order.
  Future<void> updateOrderStatus(String orderId, String status) async {
    // Stub implementation
  }

  // ── Customers ─────────────────────────────────────────────
  /// Fetches the list of registered customer users.
  Future<List<AppUser>> getAllCustomers() async {
    return [];
  }
}

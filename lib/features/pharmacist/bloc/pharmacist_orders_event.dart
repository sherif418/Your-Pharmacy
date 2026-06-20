// pharmacist_orders_event.dart
// Responsible for: defining all events for PharmacistOrdersBloc.
// Handled by the pharmacist to view/manage orders and statistics.

part of 'pharmacist_orders_bloc.dart';

abstract class PharmacistOrdersEvent extends Equatable {
  const PharmacistOrdersEvent();

  @override
  List<Object?> get props => [];
}

// ── Load Dashboard Stats & Orders ──────────────────────────
/// Fired when the Pharmacist Dashboard opens.
class PharmacistDashboardLoadRequested extends PharmacistOrdersEvent {
  const PharmacistDashboardLoadRequested();
}

// ── Update Order Status ────────────────────────────────────
/// Fired when the pharmacist transitions an order state (e.g., preparing to ready).
class PharmacistUpdateOrderStatusRequested extends PharmacistOrdersEvent {
  final String orderId;
  final String newStatus;

  const PharmacistUpdateOrderStatusRequested({
    required this.orderId,
    required this.newStatus,
  });

  @override
  List<Object?> get props => [orderId, newStatus];
}

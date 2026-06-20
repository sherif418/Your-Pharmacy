// orders_event.dart
// Responsible for: defining all events that can be sent to the OrdersBloc.
// Each event corresponds to one user action in the orders feature.

part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object?> get props => [];
}

// ── Load Customer Orders ───────────────────────────────────
/// Fired when the MyOrders screen opens, to fetch all orders for the user.
class OrdersLoadRequested extends OrdersEvent {
  final String customerId;

  const OrdersLoadRequested({required this.customerId});

  @override
  List<Object?> get props => [customerId];
}

// ── Load Order Detail ─────────────────────────────────────
/// Fired when the user taps an order card to see its details.
class OrderDetailLoadRequested extends OrdersEvent {
  final String orderId;

  const OrderDetailLoadRequested({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

// ── Place Order ───────────────────────────────────────────
/// Fired when the user submits the order medicine form.
class OrderPlaceRequested extends OrdersEvent {
  final String customerId;
  final String customerName;
  final String medicineNames;
  final String? notes;

  const OrderPlaceRequested({
    required this.customerId,
    required this.customerName,
    required this.medicineNames,
    this.notes,
  });

  @override
  List<Object?> get props => [customerId, customerName, medicineNames, notes];
}

// ── Upload Prescription ───────────────────────────────────
/// Fired when the user selects an image and submits the prescription form.
class OrderPrescriptionUploadRequested extends OrdersEvent {
  final String customerId;
  final String customerName;
  final String filePath;

  const OrderPrescriptionUploadRequested({
    required this.customerId,
    required this.customerName,
    required this.filePath,
  });

  @override
  List<Object?> get props => [customerId, customerName, filePath];
}

// ── Cancel Order ──────────────────────────────────────────
/// Fired when the user requests to cancel an order.
class OrderCancelRequested extends OrdersEvent {
  final String orderId;

  const OrderCancelRequested({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

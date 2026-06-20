// orders_state.dart
// Responsible for: defining all states that the OrdersBloc can emit.
// The UI listens to these states to render loading spinners, order lists, or errors.

part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

// ── Initial ───────────────────────────────────────────────
/// Default state before any orders have been loaded.
class OrdersInitial extends OrdersState {}

// ── Loading ───────────────────────────────────────────────
/// Emitted while any orders operation is in progress.
class OrdersLoading extends OrdersState {}

// ── Orders Loaded ─────────────────────────────────────────
/// Emitted when the list of customer orders is successfully fetched.
class OrdersLoaded extends OrdersState {
  final List<OrderModel> orders;

  const OrdersLoaded({required this.orders});

  @override
  List<Object?> get props => [orders];
}

// ── Order Detail Loaded ───────────────────────────────────
/// Emitted when a single order's details are successfully fetched.
class OrderDetailLoaded extends OrdersState {
  final OrderModel order;

  const OrderDetailLoaded({required this.order});

  @override
  List<Object?> get props => [order];
}

// ── Order Placed ──────────────────────────────────────────
/// Emitted after a new order is successfully submitted to Firestore.
class OrderPlacedSuccess extends OrdersState {}

// ── Error ─────────────────────────────────────────────────
/// Emitted when any orders operation fails.
class OrdersError extends OrdersState {
  final String message;

  const OrdersError({required this.message});

  @override
  List<Object?> get props => [message];
}

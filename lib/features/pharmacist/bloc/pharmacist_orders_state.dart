// pharmacist_orders_state.dart
// Responsible for: defining all states PharmacistOrdersBloc can emit.
// The UI listens to these to render the dashboard, orders list, and stats.

part of 'pharmacist_orders_bloc.dart';

abstract class PharmacistOrdersState extends Equatable {
  const PharmacistOrdersState();

  @override
  List<Object?> get props => [];
}

// ── Initial ───────────────────────────────────────────────
class PharmacistOrdersInitial extends PharmacistOrdersState {}

// ── Loading ───────────────────────────────────────────────
class PharmacistOrdersLoading extends PharmacistOrdersState {}

// ── Loaded ────────────────────────────────────────────────
class PharmacistOrdersLoaded extends PharmacistOrdersState {
  final List<OrderModel> orders;
  final int totalOrdersCount;
  final int pendingOrdersCount;

  const PharmacistOrdersLoaded({
    required this.orders,
    required this.totalOrdersCount,
    required this.pendingOrdersCount,
  });

  @override
  List<Object?> get props => [orders, totalOrdersCount, pendingOrdersCount];
}

// ── Error ─────────────────────────────────────────────────
class PharmacistOrdersError extends PharmacistOrdersState {
  final String message;

  const PharmacistOrdersError({required this.message});

  @override
  List<Object?> get props => [message];
}

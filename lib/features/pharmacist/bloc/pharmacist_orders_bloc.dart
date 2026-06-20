// pharmacist_orders_bloc.dart
// Responsible for: managing all operations and state for the pharmacist user interface.
// Deals with dashboard statistics, new orders listing, and status updates.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/features/orders/data/order_model.dart';
import 'package:flutter_application_1/features/pharmacist/data/pharmacist_repository.dart';

part 'pharmacist_orders_event.dart';
part 'pharmacist_orders_state.dart';

class PharmacistOrdersBloc extends Bloc<PharmacistOrdersEvent, PharmacistOrdersState> {
  final PharmacistRepository _repository;

  PharmacistOrdersBloc({required PharmacistRepository repository})
      : _repository = repository,
        super(PharmacistOrdersInitial()) {
    on<PharmacistDashboardLoadRequested>(_onDashboardLoadRequested);
    on<PharmacistUpdateOrderStatusRequested>(_onUpdateOrderStatusRequested);
  }

  Future<void> _onDashboardLoadRequested(
      PharmacistDashboardLoadRequested event, Emitter<PharmacistOrdersState> emit) async {
    emit(PharmacistOrdersLoading());
    try {
      final orders = await _repository.getAllOrders();
      final total = orders.length;
      final pending = orders.where((o) => o.status == 'pending').length;
      emit(PharmacistOrdersLoaded(
        orders: orders,
        totalOrdersCount: total,
        pendingOrdersCount: pending,
      ));
    } catch (e) {
      emit(PharmacistOrdersError(message: e.toString()));
    }
  }

  Future<void> _onUpdateOrderStatusRequested(
      PharmacistUpdateOrderStatusRequested event, Emitter<PharmacistOrdersState> emit) async {
    try {
      await _repository.updateOrderStatus(event.orderId, event.newStatus);
      add(const PharmacistDashboardLoadRequested());
    } catch (e) {
      emit(PharmacistOrdersError(message: e.toString()));
    }
  }
}

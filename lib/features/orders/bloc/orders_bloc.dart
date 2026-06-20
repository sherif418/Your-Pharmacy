// orders_bloc.dart
// Responsible for: managing all customer orders logic — loading, placing, and cancelling orders.
// Uses OrdersRepository to talk to Firestore. Has NO direct Firebase imports.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/features/orders/data/orders_repository.dart';
import 'package:flutter_application_1/features/orders/data/order_model.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository _ordersRepository;

  OrdersBloc({required OrdersRepository ordersRepository})
      : _ordersRepository = ordersRepository,
        super(OrdersInitial()) {
    on<OrdersLoadRequested>(_onLoadRequested);
    on<OrderDetailLoadRequested>(_onDetailLoadRequested);
    on<OrderPlaceRequested>(_onPlaceRequested);
    on<OrderPrescriptionUploadRequested>(_onPrescriptionUploadRequested);
    on<OrderCancelRequested>(_onCancelRequested);
  }

  // ── Load Customer Orders ───────────────────────────────────
  Future<void> _onLoadRequested(
      OrdersLoadRequested event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());
    try {
      final orders = await _ordersRepository.getCustomerOrders(event.customerId);
      emit(OrdersLoaded(orders: orders));
    } catch (e) {
      emit(OrdersError(message: e.toString()));
    }
  }

  // ── Load Order Detail ─────────────────────────────────────
  Future<void> _onDetailLoadRequested(
      OrderDetailLoadRequested event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());
    try {
      final order = await _ordersRepository.getOrderById(event.orderId);
      emit(OrderDetailLoaded(order: order));
    } catch (e) {
      emit(OrdersError(message: e.toString()));
    }
  }

  // ── Place Order ───────────────────────────────────────────
  Future<void> _onPlaceRequested(
      OrderPlaceRequested event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());
    try {
      final order = OrderModel(
        id: '',
        customerId: event.customerId,
        customerName: event.customerName,
        medicineNames: event.medicineNames,
        status: 'pending',
        createdAt: DateTime.now(),
        notes: event.notes,
      );
      await _ordersRepository.placeOrder(order);
      emit(OrderPlacedSuccess());
    } catch (e) {
      emit(OrdersError(message: e.toString()));
    }
  }

  // ── Upload Prescription ───────────────────────────────────
  Future<void> _onPrescriptionUploadRequested(
      OrderPrescriptionUploadRequested event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());
    try {
      final prescriptionUrl = await _ordersRepository.uploadPrescription(
        customerId: event.customerId,
        filePath: event.filePath,
      );
      final order = OrderModel(
        id: '',
        customerId: event.customerId,
        customerName: event.customerName,
        medicineNames: '',
        prescriptionUrl: prescriptionUrl,
        status: 'pending',
        createdAt: DateTime.now(),
      );
      await _ordersRepository.placeOrder(order);
      emit(OrderPlacedSuccess());
    } catch (e) {
      emit(OrdersError(message: e.toString()));
    }
  }

  // ── Cancel Order ──────────────────────────────────────────
  Future<void> _onCancelRequested(
      OrderCancelRequested event, Emitter<OrdersState> emit) async {
    try {
      await _ordersRepository.cancelOrder(event.orderId);
    } catch (e) {
      emit(OrdersError(message: e.toString()));
    }
  }
}

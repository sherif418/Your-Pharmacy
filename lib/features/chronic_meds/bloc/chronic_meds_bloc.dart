// chronic_meds_bloc.dart
// Responsible for: managing all logic for the customer's chronic medications list.
// Handles loading, adding, and deleting medications via ChronicMedsRepository.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/features/chronic_meds/data/chronic_meds_repository.dart';

part 'chronic_meds_event.dart';
part 'chronic_meds_state.dart';

class ChronicMedsBloc extends Bloc<ChronicMedsEvent, ChronicMedsState> {
  final ChronicMedsRepository _repository;

  ChronicMedsBloc({required ChronicMedsRepository repository})
      : _repository = repository,
        super(ChronicMedsInitial()) {
    on<ChronicMedsLoadRequested>(_onLoadRequested);
    on<ChronicMedAddRequested>(_onAddRequested);
    on<ChronicMedDeleteRequested>(_onDeleteRequested);
  }

  // ── Load Meds ─────────────────────────────────────────────
  Future<void> _onLoadRequested(
      ChronicMedsLoadRequested event, Emitter<ChronicMedsState> emit) async {
    emit(ChronicMedsLoading());
    try {
      final meds = await _repository.getMeds(event.customerId);
      emit(ChronicMedsLoaded(meds: meds));
    } catch (e) {
      emit(ChronicMedsError(message: e.toString()));
    }
  }

  // ── Add Med ───────────────────────────────────────────────
  Future<void> _onAddRequested(
      ChronicMedAddRequested event, Emitter<ChronicMedsState> emit) async {
    emit(ChronicMedsLoading());
    try {
      await _repository.addMed(
        customerId: event.customerId,
        medicineName: event.medicineName,
        dose: event.dose,
      );
      emit(ChronicMedAddSuccess());
      // Reload the list automatically after adding
      final meds = await _repository.getMeds(event.customerId);
      emit(ChronicMedsLoaded(meds: meds));
    } catch (e) {
      emit(ChronicMedsError(message: e.toString()));
    }
  }

  // ── Delete Med ────────────────────────────────────────────
  Future<void> _onDeleteRequested(
      ChronicMedDeleteRequested event, Emitter<ChronicMedsState> emit) async {
    try {
      await _repository.deleteMed(event.medId);
    } catch (e) {
      emit(ChronicMedsError(message: e.toString()));
    }
  }
}

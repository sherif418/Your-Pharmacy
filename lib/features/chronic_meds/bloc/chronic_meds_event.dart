// chronic_meds_event.dart
// Responsible for: defining all events for ChronicMedsBloc.
// Each event is one user action related to managing chronic medications.

part of 'chronic_meds_bloc.dart';

abstract class ChronicMedsEvent extends Equatable {
  const ChronicMedsEvent();

  @override
  List<Object?> get props => [];
}

// ── Load Meds ─────────────────────────────────────────────
/// Fired when the ChronicMedsScreen opens, to fetch the user's list.
class ChronicMedsLoadRequested extends ChronicMedsEvent {
  final String customerId;

  const ChronicMedsLoadRequested({required this.customerId});

  @override
  List<Object?> get props => [customerId];
}

// ── Add Med ───────────────────────────────────────────────
/// Fired when the user submits the Add Chronic Med form.
class ChronicMedAddRequested extends ChronicMedsEvent {
  final String customerId;
  final String medicineName;
  final String dose;

  const ChronicMedAddRequested({
    required this.customerId,
    required this.medicineName,
    required this.dose,
  });

  @override
  List<Object?> get props => [customerId, medicineName, dose];
}

// ── Delete Med ────────────────────────────────────────────
/// Fired when the user swipes to delete or taps the delete icon on a med card.
class ChronicMedDeleteRequested extends ChronicMedsEvent {
  final String medId;

  const ChronicMedDeleteRequested({required this.medId});

  @override
  List<Object?> get props => [medId];
}

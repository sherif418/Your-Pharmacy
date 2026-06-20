// chronic_meds_state.dart
// Responsible for: defining all states ChronicMedsBloc can emit.
// The UI listens to these to show the list, loading, or error screens.

part of 'chronic_meds_bloc.dart';

abstract class ChronicMedsState extends Equatable {
  const ChronicMedsState();

  @override
  List<Object?> get props => [];
}

// ── Initial ───────────────────────────────────────────────
/// Default state before any medications have been loaded.
class ChronicMedsInitial extends ChronicMedsState {}

// ── Loading ───────────────────────────────────────────────
/// Emitted during any async operation (load, add, delete).
class ChronicMedsLoading extends ChronicMedsState {}

// ── Loaded ────────────────────────────────────────────────
/// Emitted after the medication list is successfully fetched.
class ChronicMedsLoaded extends ChronicMedsState {
  /// Each item is a map with keys: 'id', 'name', 'dose'.
  final List<Map<String, String>> meds;

  const ChronicMedsLoaded({required this.meds});

  @override
  List<Object?> get props => [meds];
}

// ── Add Success ───────────────────────────────────────────
/// Emitted after a new medication is successfully added.
class ChronicMedAddSuccess extends ChronicMedsState {}

// ── Error ─────────────────────────────────────────────────
/// Emitted when any chronic meds operation fails.
class ChronicMedsError extends ChronicMedsState {
  final String message;

  const ChronicMedsError({required this.message});

  @override
  List<Object?> get props => [message];
}

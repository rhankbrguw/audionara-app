import 'package:equatable/equatable.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class UpdateStreamQuality extends SettingsEvent {
  const UpdateStreamQuality({required this.kbps});
  final int kbps;

  @override
  List<Object?> get props => [kbps];
}

class ToggleExplicitFilter extends SettingsEvent {
  const ToggleExplicitFilter({required this.filterEnabled});
  final bool filterEnabled;

  @override
  List<Object?> get props => [filterEnabled];
}

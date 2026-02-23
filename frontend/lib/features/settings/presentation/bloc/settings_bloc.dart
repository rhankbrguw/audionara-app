import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required this.prefs}) : super(const SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateStreamQuality>(_onUpdateStreamQuality);
    on<ToggleExplicitFilter>(_onToggleExplicitFilter);
  }

  final SharedPreferences prefs;

  void _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) {
    final kbps = prefs.getInt('stream_quality') ?? 128;
    final filter = prefs.getBool('filter_explicit') ?? true;
    emit(SettingsState(streamQualityKbps: kbps, filterExplicit: filter));
  }

  Future<void> _onUpdateStreamQuality(
    UpdateStreamQuality event,
    Emitter<SettingsState> emit,
  ) async {
    await prefs.setInt('stream_quality', event.kbps);
    emit(state.copyWith(streamQualityKbps: event.kbps));
  }

  Future<void> _onToggleExplicitFilter(
    ToggleExplicitFilter event,
    Emitter<SettingsState> emit,
  ) async {
    await prefs.setBool('filter_explicit', event.filterEnabled);
    emit(state.copyWith(filterExplicit: event.filterEnabled));
  }
}

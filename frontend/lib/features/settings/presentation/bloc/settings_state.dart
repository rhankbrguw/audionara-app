import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.streamQualityKbps = 128,
    this.filterExplicit = true,
  });

  final int streamQualityKbps;
  final bool filterExplicit;

  SettingsState copyWith({
    int? streamQualityKbps,
    bool? filterExplicit,
  }) {
    return SettingsState(
      streamQualityKbps: streamQualityKbps ?? this.streamQualityKbps,
      filterExplicit: filterExplicit ?? this.filterExplicit,
    );
  }

  @override
  List<Object?> get props => [streamQualityKbps, filterExplicit];
}

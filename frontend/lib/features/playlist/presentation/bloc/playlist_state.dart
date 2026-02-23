import 'package:equatable/equatable.dart';

import '../../domain/entities/playlist_item.dart';

sealed class PlaylistState extends Equatable {
  const PlaylistState();

  @override
  List<Object?> get props => [];
}

class PlaylistInitial extends PlaylistState {}

class PlaylistLoading extends PlaylistState {}

class PlaylistLoaded extends PlaylistState {
  const PlaylistLoaded({required this.favorites});

  final List<PlaylistItem> favorites;

  @override
  List<Object?> get props => [favorites];
}

class PlaylistTrackStatus extends PlaylistState {
  const PlaylistTrackStatus({required this.trackId, required this.isSaved});

  final String trackId;
  final bool isSaved;

  @override
  List<Object?> get props => [trackId, isSaved];
}

class PlaylistError extends PlaylistState {
  const PlaylistError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

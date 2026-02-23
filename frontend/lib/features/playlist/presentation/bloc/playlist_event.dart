import 'package:equatable/equatable.dart';

import '../../domain/entities/playlist_item.dart';

sealed class PlaylistEvent extends Equatable {
  const PlaylistEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends PlaylistEvent {}

class ToggleFavoriteStatus extends PlaylistEvent {
  const ToggleFavoriteStatus({required this.item});

  final PlaylistItem item;

  @override
  List<Object?> get props => [item];
}

class CheckFavoriteStatus extends PlaylistEvent {
  const CheckFavoriteStatus({required this.trackId});

  final String trackId;

  @override
  List<Object?> get props => [trackId];
}

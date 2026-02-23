import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/playlist_repository.dart';
import 'playlist_event.dart';
import 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  PlaylistBloc({required this.repository}) : super(PlaylistInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavoriteStatus>(_onToggleFavoriteStatus);
    on<CheckFavoriteStatus>(_onCheckFavoriteStatus);
  }

  final PlaylistRepository repository;

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(PlaylistLoading());
    try {
      final items = await repository.getAllSavedTracks();
      emit(PlaylistLoaded(favorites: items));
    } catch (e) {
      emit(PlaylistError(message: 'Failed to load favorites: $e'));
    }
  }

  Future<void> _onCheckFavoriteStatus(
    CheckFavoriteStatus event,
    Emitter<PlaylistState> emit,
  ) async {
    try {
      final isSaved = await repository.isTrackSaved(event.trackId);
      emit(PlaylistTrackStatus(trackId: event.trackId, isSaved: isSaved));
    } catch (e) {
      // Gracefully ignore or log db errors without crashing player
      emit(PlaylistTrackStatus(trackId: event.trackId, isSaved: false));
    }
  }

  Future<void> _onToggleFavoriteStatus(
    ToggleFavoriteStatus event,
    Emitter<PlaylistState> emit,
  ) async {
    try {
      final isSaved = await repository.isTrackSaved(event.item.trackId);
      if (isSaved) {
        await repository.removeTrack(event.item.trackId);
      } else {
        await repository.addTrack(event.item);
      }
      
      // Emit the updated status dynamically
      emit(PlaylistTrackStatus(trackId: event.item.trackId, isSaved: !isSaved));
    } catch (e) {
      emit(PlaylistError(message: 'Failed to toggle favorite.'));
    }
  }
}

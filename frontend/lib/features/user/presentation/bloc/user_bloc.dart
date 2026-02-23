import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserInitial()) {
    on<LoadUser>(_onLoadUser);
  }

  void _onLoadUser(LoadUser event, Emitter<UserState> emit) {
    emit(const UserLoaded(username: 'Guest User'));
  }
}

import 'package:equatable/equatable.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoaded extends UserState {
  const UserLoaded({required this.username});

  final String username;

  @override
  List<Object?> get props => [username];
}

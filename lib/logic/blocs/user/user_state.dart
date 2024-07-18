part of 'user_bloc.dart';

sealed class UserState {}

final class InitialUserState extends UserState {}

final class LoadingUserState extends UserState {}

final class LoadedUsersState extends UserState {
  DocumentSnapshot<Map<String, dynamic>> user;

  LoadedUsersState(this.user);
}

final class ErrorUserState extends UserState {
  final String message;

  ErrorUserState(this.message);
}

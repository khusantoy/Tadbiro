part of 'user_bloc.dart';

sealed class UserEvent {}

final class GetUserEvent extends UserEvent {
  final String email;

  GetUserEvent(this.email);
}

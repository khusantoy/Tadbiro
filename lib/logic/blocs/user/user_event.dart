part of 'user_bloc.dart';

sealed class UserEvent {}

final class GetUserEvent extends UserEvent {
  final String email;

  GetUserEvent(this.email);
}

final class EditUserEvent extends UserEvent {
  final String? username;
  final File? imageFile;

  EditUserEvent(this.username, this.imageFile);
}

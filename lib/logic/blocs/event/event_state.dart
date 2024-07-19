part of 'event_bloc.dart';

sealed class EventState {}

final class InitialEventState extends EventState {}

final class LoadingEventState extends EventState {}

final class LoadedEventsState extends EventState {
  final List<Event> events;

  LoadedEventsState(this.events);
}

final class ErrorEventState extends EventState {
  final String message;

  ErrorEventState(this.message);
}

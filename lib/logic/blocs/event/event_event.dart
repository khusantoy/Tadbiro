part of 'event_bloc.dart';

sealed class EventEvent {}

final class GetEventsEvent extends EventEvent {}

final class AddEventEvent extends EventEvent {
  String title;
  String timestamp;
  String description;
  File imageFile;
  String latitude;
  String longitude;
  String location;

  AddEventEvent({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.imageFile,
    required this.latitude,
    required this.longitude,
    required this.location,
  });
}

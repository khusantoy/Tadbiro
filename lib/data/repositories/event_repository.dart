import 'dart:io';

import 'package:tadbiro/data/models/event.dart';
import 'package:tadbiro/services/event_firebase_services.dart';

class EventRepository {
  final EventFirebaseServices _eventFirebaseServices;

  EventRepository({
    required EventFirebaseServices eventFirebaseServices,
  }) : _eventFirebaseServices = eventFirebaseServices;

  Stream<List<Event>> getEvents() async* {
    try {
      await for (var snapshot in _eventFirebaseServices.getEvents()) {
        List<Event> events =
            snapshot.docs.map((doc) => Event.fromFirestore(doc)).toList();
        yield events;
      }
    } catch (e) {
      yield [];
      rethrow;
    }
  }

  Future<void> addEvent(
    String title,
    String date,
    String description,
    File imageFile,
    String latitude,
    String longitude,
    String location,
  ) async {
    await _eventFirebaseServices.addEvent(
      title,
      date,
      description,
      imageFile,
      latitude,
      longitude,
      location,
    );
  }

  Future<void> makeLiked(String id) async {
    await _eventFirebaseServices.makeLiked(id);
  }
}

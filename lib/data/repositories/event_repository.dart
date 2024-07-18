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
        List<Event> events = snapshot.docs.map((doc) => Event.fromFirestore(doc)).toList();
        yield events;
      }
    } catch (e) {
      yield [];
      rethrow;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class EventFirebaseServices {
  final _eventCollection = FirebaseFirestore.instance.collection("events");

  Stream<QuerySnapshot> getEvents() async* {
    yield* _eventCollection.snapshots();
  }
}

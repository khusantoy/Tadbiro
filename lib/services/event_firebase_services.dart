import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EventFirebaseServices {
  final _eventCollection = FirebaseFirestore.instance.collection("events");
  final _eventsImageStorage = FirebaseStorage.instance;

  Stream<QuerySnapshot> getEvents() async* {
    yield* _eventCollection.snapshots();
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
    final imageReference = _eventsImageStorage
        .ref()
        .child("events")
        .child("images")
        .child("$title.jpg");

    final uploadTask = imageReference.putFile(imageFile);

    await uploadTask.whenComplete(() async {
      final imageUrl = await imageReference.getDownloadURL();

      await _eventCollection.add({
        "creatorId": FirebaseAuth.instance.currentUser!.email,
        "date": date,
        "description": description,
        "imageUrl": imageUrl,
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
        "likedUsers": [],
        "location": location,
        "participants": [
          {
            "userId": FirebaseAuth.instance.currentUser!.email,
            "amount": "1",
          }
        ],
        "title": title,
      });
    });
  }
}

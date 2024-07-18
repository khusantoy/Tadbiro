import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String creatorId;
  Timestamp date;
  String description;
  String imageUrl;
  String latitude;
  String longitude;
  String location;
  List<String> likedUsers;
  List<Participant> participants;
  String title;

  Event({
    required this.creatorId,
    required this.date,
    required this.description,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.likedUsers,
    required this.participants,
    required this.title,
  });

  factory Event.fromFirestore(DocumentSnapshot doc) {
    print(doc['latitude'].runtimeType);
    Map data = doc.data() as Map;
    return Event(
      creatorId: data['creatorId'] ?? '',
      date: data['date'] ?? Timestamp.now(),
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      latitude: data['latitude'] ?? 0.0,
      longitude: data['longitude'] ?? 0.0,
      location: data['location'] ?? '',
      likedUsers: data['likedUsers'] != null
          ? List<String>.from(data['likedUsers'])
          : [],
      participants: data['participants'] != null
          ? (data['participants'] as List)
              .map((participant) => Participant.fromMap(participant))
              .toList()
          : [],
      title: data['title'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'creatorId': creatorId,
      'date': date,
      'description': description,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
      'location': location,
      // 'likedUsers': likedUsers.map((user) => user.toMap()).toList(),
      'participants':
          participants.map((participant) => participant.toMap()).toList(),
      'title': title,
    };
  }
}

class LikedUser {
  String userId;

  LikedUser({required this.userId});

  factory LikedUser.fromMap(Map<String, dynamic> data) {
    return LikedUser(
      userId: data['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
    };
  }
}

class Participant {
  String amount;
  String userId;

  Participant({required this.amount, required this.userId});

  factory Participant.fromMap(Map<String, dynamic> data) {
    return Participant(
      amount: data['amount'] ?? 0,
      userId: data['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'userId': userId,
    };
  }
}

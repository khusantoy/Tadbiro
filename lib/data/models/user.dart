import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String username;
  String email;
  String contentUrl;
  List<String> accepted;
  List<String> denied;
  List<String> favourities;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.contentUrl,
    required this.accepted,
    required this.denied,
    required this.favourities,
  });

  factory User.fromQuerySnapshot(QueryDocumentSnapshot query) {
    return User(
      id: query.id,
      username: query['username'],
      email: query['email'],
      contentUrl: query['contentUrl'],
      accepted: query['accepted'],
      denied: query['denied'],
      favourities: query['favourities'],
    );
  }
}

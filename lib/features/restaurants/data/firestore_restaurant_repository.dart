import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ts_6_2_4/features/restaurants/data/restaurant_repository.dart';
import 'package:ts_6_2_4/features/restaurants/model/restaurant.dart';

class FirestoreRestaurantRepository implements RestaurantRepository {
  final FirebaseFirestore _db;

  FirestoreRestaurantRepository(this._db);

  @override
  Future<void> addRestaurant(Restaurant restaurant) async {
    await _db.collection("restaurants").add(restaurant.toMap());
  }

  @override
  Stream<List<Restaurant>> getAllRestaurantsAsStream({num? plz, int? overallRating}) {
    return _db
        .collection("restaurants")
        .where("plz", isEqualTo: plz)
        .where("overall_rating", isEqualTo: overallRating)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) => Restaurant.fromMap(doc.data(), doc.id)).toList(),
        );
  }

  @override
  Stream<List<Restaurant>> filterRestaurantByPLZ(num plz) {
    return _db
        .collection("restaurants")
        .where("plz", isEqualTo: plz)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) => Restaurant.fromMap(doc.data(), doc.id)).toList(),
        );
  }

  @override
  Stream<List<Restaurant>> filterRestaurantByRating(int overallRating) {
    return _db
        .collection("restaurants")
        .where("overall_rating", isEqualTo: overallRating)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) => Restaurant.fromMap(doc.data(), doc.id)).toList(),
        );
  }
}

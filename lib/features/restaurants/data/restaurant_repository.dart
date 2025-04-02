import 'package:ts_6_2_4/features/restaurants/model/restaurant.dart';

abstract class RestaurantRepository {
  Future<void> addRestaurant(Restaurant restaurant);
  Stream<List<Restaurant>> getAllRestaurantsAsStream({num? plz, int? overallRating});
  Stream<List<Restaurant>> filterRestaurantByRating(int overallRating);
  Stream<List<Restaurant>> filterRestaurantByPLZ(num plz);
}

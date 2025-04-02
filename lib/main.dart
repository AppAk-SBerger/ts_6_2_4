import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ts_6_2_4/features/restaurants/data/firestore_restaurant_repository.dart';
import 'package:ts_6_2_4/features/restaurants/data/restaurant_repository.dart';
import 'package:ts_6_2_4/features/restaurants/screens/restaurant_screen.dart';
import 'firebase_options.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RestaurantRepository restaurantRepository = FirestoreRestaurantRepository(firestore);

  runApp(MainApp(restaurantRepository: restaurantRepository));
}

class MainApp extends StatelessWidget {
  final RestaurantRepository restaurantRepository;
  const MainApp({required this.restaurantRepository, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RestaurantScreen(restaurantRepository: restaurantRepository));
  }
}

import 'package:flutter/material.dart';
import 'package:ts_6_2_4/features/restaurants/data/restaurant_repository.dart';
import 'package:ts_6_2_4/features/restaurants/model/restaurant.dart';

class RestaurantScreen extends StatefulWidget {
  final RestaurantRepository restaurantRepository;
  const RestaurantScreen({required this.restaurantRepository, super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final TextEditingController plzController = TextEditingController();
  num? filterByPLZ;
  int? filterByRating;

  // void dropdownCallback(int? selectedValue) {
  //   if (selectedValue is int) {
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String dropdownButtonLabel = "Filtern nach Bewertung";

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Restaurants filtern")),
      body: Column(
        children: [
          StreamBuilder(
            stream: widget.restaurantRepository.getAllRestaurantsAsStream(
              plz: filterByPLZ,
              overallRating: filterByRating,
            ),
            builder: (BuildContext context, AsyncSnapshot<List<Restaurant>> snapshot) {
              if (snapshot.hasError) {
                return Text("Fehler ${snapshot.error}");
              } else if (snapshot.connectionState == ConnectionState.active && !snapshot.hasData) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData && snapshot.data != null) {
                final restaurants = snapshot.data!;

                if (restaurants.isEmpty) {
                  return Center(child: Text("Keine Einträge vorhanden."));
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = restaurants[index];
                    return ListTile(
                      title: Center(child: Text(restaurant.name)),
                      subtitle: Column(
                        children: [
                          Text("PLZ: ${restaurant.plz}"),
                          Text("Bewertung: ${restaurant.overallRating}"),
                        ],
                      ),
                    );
                  },
                );
              }
              return Text("Keine Einträge vorhanden.");
            },
          ),
          SizedBox(height: 16),
          SizedBox(
            width: screenWidth * 0.5,
            child: TextField(
              controller: plzController,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: "PLZ"),
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              setState(() {
                filterByPLZ = num.tryParse(plzController.text);
              });
            },
            child: Text("Filtern nach PLZ"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                value: dropdownButtonLabel,
                items: const [
                  DropdownMenuItem(
                    value: "Filtern nach Bewertung",
                    child: Text("Filtern nach Bewertung"),
                  ),
                  DropdownMenuItem(value: 5, child: Text("Bewertung: 5")),
                  DropdownMenuItem(value: 4, child: Text("Bewertung: 4")),
                  DropdownMenuItem(value: 3, child: Text("Bewertung: 3")),
                  DropdownMenuItem(value: 2, child: Text("Bewertung: 2")),
                  DropdownMenuItem(value: 1, child: Text("Bewertung: 1")),
                ],
                onChanged:
                    (value) => {
                      setState(() {
                        dropdownButtonLabel = value.toString();
                        filterByRating =
                            value != "Filtern nach Bewertung"
                                ? int.tryParse(value.toString())
                                : null;
                      }),
                    },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

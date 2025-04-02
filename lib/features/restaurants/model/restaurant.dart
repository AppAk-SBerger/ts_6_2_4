class Restaurant {
  final String name;
  final num plz;
  final int overallRating;
  final String docID;

  Restaurant({
    required this.name,
    required this.plz,
    required this.overallRating,
    required this.docID,
  });

  factory Restaurant.fromMap(Map<String, dynamic> data, String docID) {
    return Restaurant(
      name: data["name"] as String,
      plz: data["plz"] as num,
      overallRating: data["overall_rating"] as int,
      docID: docID,
    );
  }

  Map<String, dynamic> toMap() {
    return {"name": name, "plz": plz, "overall_rating": overallRating};
  }
}

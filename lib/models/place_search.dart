class PlaceSearch {
  final String description;
  final String placeId;

  // ignore: sort_constructors_first
  PlaceSearch({required this.description, required this.placeId});

  // ignore: sort_constructors_first
  factory PlaceSearch.fromJson(Map<String, dynamic> json) {
    return PlaceSearch(
        description: json['description'], placeId: json['place_id']);
  }
}

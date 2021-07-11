import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:new_app/services/geolocator_services.dart';
import 'package:new_app/services/marker_LatLng.dart';
import 'package:new_app/services/places_service.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();
  final placeMarker = PlaceMarker();

  Position? currentLocation;
  String currentAddress = '';

  //List<PlaceSearch>? searchResults;

  // ignore: sort_constructors_first
  ApplicationBloc() {
    setCurrentLocation();
  }

  Future? setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    await setMarkerLatLng(
        currentLocation!.latitude, currentLocation!.longitude);
    notifyListeners();
  }

  /*Future? searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }*/

  Future? setMarkerLatLng(double lat, double long) async {
    currentAddress = await placeMarker.getAddressFromLatLng(lat, long);
    notifyListeners();
  }
}

import 'package:geocoding/geocoding.dart';

class PlaceMarker {
  String? currentAddress;
  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    var placemarks = await placemarkFromCoordinates(latitude, longitude);
    var place = placemarks[0];
    return currentAddress =
        '${place.name},${place.subLocality},${place.locality}, ${place.postalCode}, ${place.country}';
  }
}

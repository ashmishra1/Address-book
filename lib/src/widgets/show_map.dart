import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class ShowMap extends StatefulWidget {
  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final TextEditingController searchController = TextEditingController();

  Set<Marker> markers = {};

  var searchLocation = '';
  var _currentPosition;
  String _currentAddress = '';
  double latitude = 0;
  double longitude = 0;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> getSearchedLocation() async {
    try {
      var locations = await locationFromAddress(searchController.text);
      setState(() {
        latitude = locations[0].latitude;
        longitude = locations[0].longitude;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      var placemarks = await placemarkFromCoordinates(latitude, longitude);
      var place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.name},${place.subLocality},${place.locality}, ${place.postalCode}, ${place.country}';
      });
    } catch (e) {
      print(e);
    }
    return;
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    var lat = _currentPosition.latitude;
    var long = _currentPosition.longitude;

    setState(() {
      latitude = double.parse('$lat');
      longitude = double.parse('$long');
    });

    await _getAddressFromLatLng();
    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 13,
        ),
      ),
    );
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 400,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(latitude, longitude),
                    zoom: 2,
                  ),
                  markers: <Marker>{
                    Marker(
                      onTap: () {},
                      draggable: true,
                      markerId: MarkerId('Marker'),
                      position: LatLng(latitude, longitude),
                      onDragEnd: ((newPosition) {
                        latitude = newPosition.latitude;
                        longitude = newPosition.longitude;
                        setState(() {
                          _getAddressFromLatLng();
                        });
                      }),
                    )
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapToolbarEnabled: false,
                  mapType: MapType.normal,
                  buildingsEnabled: true,
                  zoomControlsEnabled: false,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Color(0xFFFFFFFF),
                      ),
                      child: TextField(
                          controller: searchController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              labelText: 'Search',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              /*icon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),*/
                              border: InputBorder.none)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: () {
                            getCurrentLocation();
                          },
                          child: Icon(Icons.my_location),
                        )),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              _currentAddress,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: MaterialButton(
              onPressed: () {},
              elevation: 0.0,
              minWidth: double.maxFinite,
              color: Colors.orange,
              child: Text('Add details'),
            ),
          ),
        ],
      ),
    );
  }
}

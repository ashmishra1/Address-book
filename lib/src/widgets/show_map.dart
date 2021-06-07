import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class ShowMap extends StatefulWidget {
  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> markers = {};

  var locationMessage = ' ';
  double latitude = 20.5937;
  double longitude = 78.9629;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    var lat = position.latitude;
    var long = position.longitude;

    setState(() {
      latitude = double.parse('$lat');
      longitude = double.parse('$long');
    });

    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 18,
        ),
      ),
    );
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(latitude, longitude),
              zoom: 11,
            ),
            markers: <Marker>{
              Marker(
                  onTap: () {
                    print('Tapped');
                  },
                  draggable: true,
                  markerId: MarkerId('Marker'),
                  position: LatLng(latitude, longitude),
                  onDragEnd: ((newPosition) {
                    print(newPosition.latitude);
                    print(newPosition.longitude);
                  }))
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: true,
            mapType: MapType.normal,
            buildingsEnabled: true,
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
          )
        ],
      ),
    );
  }
}

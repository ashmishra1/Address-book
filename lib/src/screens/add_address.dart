import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_app/blocs/application_blocs.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddAdd extends StatefulWidget {
  const AddAdd({Key? key}) : super(key: key);

  @override
  _AddAddState createState() => _AddAddState();
}

class _AddAddState extends State<AddAdd> {
  var Lati;
  var Longi;
  String Title = 'No Title';
  String Address = 'No Address';
  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    Future getValue() async {
      await applicationBloc.setCurrentLocation();
      Lati = applicationBloc.currentLocation!.latitude;
      Longi = applicationBloc.currentLocation!.longitude;
    }

    @override
    void initState() {
      super.initState();
      getValue();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
        backgroundColor: Colors.orange,
      ),
      body: (applicationBloc.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    /*Container(
                      height: 60,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          suffix: Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                        ),
                        onChanged: (value) =>
                            applicationBloc.searchPlaces(value),
                      ),
                    ),*/
                    Stack(
                      children: [
                        Container(
                          height: 250.0,
                          child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      applicationBloc.currentLocation!.latitude,
                                      applicationBloc
                                          .currentLocation!.longitude),
                                  zoom: 13),
                              myLocationEnabled: true,
                              myLocationButtonEnabled: false,
                              markers: <Marker>{
                                Marker(
                                  onTap: () {},
                                  draggable: true,
                                  markerId: MarkerId('Marker'),
                                  position: LatLng(
                                      applicationBloc.currentLocation!.latitude,
                                      applicationBloc
                                          .currentLocation!.longitude),
                                  onDragEnd: ((newPosition) {
                                    Lati = newPosition.latitude;
                                    Longi = newPosition.longitude;
                                    applicationBloc.setMarkerLatLng(
                                        Lati, Longi);
                                  }),
                                )
                              }),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: FloatingActionButton(
                              backgroundColor: Colors.white,
                              elevation: 4,
                              onPressed: () {
                                applicationBloc.setCurrentLocation();
                              },
                              child: Icon(Icons.my_location)),
                        )
                        /*if (applicationBloc.searchResults != null &&
                            applicationBloc.searchResults!.length != null)
                          Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                backgroundBlendMode: BlendMode.darken),
                          ),
                        Container(
                          height: 300.0,
                          child: ListView.builder(
                              itemCount: applicationBloc.searchResults!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    applicationBloc
                                        .searchResults![index].description,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }),
                        )*/
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          //borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                      child: Text(
                        applicationBloc.currentAddress,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                    /*Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      //padding: const EdgeInsets.only(top: 20.0),
                      child: TextField(
                        maxLength: 50,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          //border: OutlineInputBorder(
                          //  borderRadius: BorderRadius.circular(10),
                          // ),
                          labelText: 'Title',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                      ),
                    ),*/
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      //padding: const EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                        maxLength: 100,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          //border: OutlineInputBorder(
                          //  borderRadius: BorderRadius.circular(10),
                          // ),
                          labelText: 'Title',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        onChanged: (value) {
                          Title = value;
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      padding: const EdgeInsets.only(top: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextFormField(
                        maxLines: 8,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                        onChanged: (value) {
                          Address = value;
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: MaterialButton(
                        onPressed: () {
                          Add();
                          Navigator.of(context).pop(Fluttertoast.showToast(
                              msg: 'Address saved',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              fontSize: 16.0));
                        },
                        color: Colors.orange,
                        highlightElevation: 8,
                        minWidth: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            'Save',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  void Add() {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes');

    var data = {
      'latitude': Lati,
      'longitude': Longi,
      'title': Title,
      'address': Address,
      'created': DateTime.now(),
    };

    ref.add(data);
  }
}

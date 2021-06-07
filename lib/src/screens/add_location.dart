import 'package:flutter/material.dart';

import 'package:new_app/src/widgets/show_map.dart';

class AddLocation extends StatefulWidget {
  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Add Location'),
      ),
      body: Stack(
        children: <Widget>[
          ShowMap(),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Color(0xFFFFFFFF),
              ),
              child: Row(
                children: [
                  TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          labelText: 'Search',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          icon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          border: InputBorder.none)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

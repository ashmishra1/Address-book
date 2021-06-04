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
          TextFormField(),
          ShowMap(),
        ],
      ),
    );
  }
}

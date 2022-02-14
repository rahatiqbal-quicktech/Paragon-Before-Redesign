import 'package:flutter/material.dart';

class ShowMap extends StatefulWidget {
  // const ShowMap({ Key? key }) : super(key: key);

  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Locations"),
      ),

      // body: GoogleMap,
    );
  }
}

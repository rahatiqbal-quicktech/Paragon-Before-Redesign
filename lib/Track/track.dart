import 'dart:ffi';

import 'package:courier/Track/anotherparcelstracklist.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

final firebasereference = FirebaseFirestore.instance.collection('location');

class Track extends StatefulWidget {
  // const Track({String id, Key? key }) : super(key: key);
  // ignore: non_constant_identifier_names
  var parcelid;
  Track(this.parcelid);

  @override
  TrackState createState() => TrackState();
}

class TrackState extends State<Track> {
  //
  final loc.Location location = loc.Location();
  GoogleMapController _controller;
  bool _added = false;
  var lat;
  var long;
  //

  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    final id = widget.parcelid;
    try {
      final DocumentSnapshot doc = await firebasereference.doc(id).get();
      if (!doc.exists) {
        lat = 0;
        long = 0;
      } else {
        lat = doc['latitude'];
        long = doc['longitude'];
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Carrier's Location",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.black87),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white70),
          onPressed: () => Get.back(),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('location')
            .doc(widget.parcelid)
            .snapshots(),
        builder: (context, snapshot) // OLD BUILDER
            // builder: (context, snapshot)
            {
          try {
            if (snapshot.hasData) {
              final values = snapshot.data;
              final lat = values['latitude'];
              final long = values['longitude'];
            }
          } catch (e) {}

          if (_added) {
            mymap(snapshot);
          }
          // if (!snapshot.data.docs
          //     .singleWhere((element) => element.id == widget.parcelid)
          //     .exists) {
          //   return Center(
          //     child: Column(
          //       children: [
          //         CircularProgressIndicator(),
          //         SizedBox(
          //           height: 20,
          //         ),
          //         Text(
          //           "Parcel is yet to be assigned",
          //           style: TextStyle(
          //             fontSize: 20,
          //             color: Colors.black87,
          //           ),
          //         )
          //       ],
          //     ),
          //   );
          // }
          if (snapshot.hasError) {
            // Get.to(AnotherParcelsTrackList());
            return Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Parcel is yet to be assigned",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  )
                ],
              ),
            );
          } else
            return GoogleMap(
              mapType: MapType.normal,
              markers: {
                Marker(
                    position: LatLng(
                      snapshot.data.docs.singleWhere((element) =>
                          element.id == widget.parcelid)['latitude'],
                      // snapshot.data['latitude'],
                      // snapshot.data.docs[widget.parcelid]['latitude'],
                      //
                      snapshot.data.docs.singleWhere((element) =>
                          element.id == widget.parcelid)['longitude'],
                      // snapshot.data()['longitude'],

                      // snapshot.data.docs[widget.parcelid]['longitude'],
                    ),

                    // LatLng(23.80682650343888, 90.36899211099205),

                    // LatLng(lat, long),
                    markerId: MarkerId('id'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueMagenta)),
              },
              initialCameraPosition: CameraPosition(
                  target:
                      // LatLng(lat, long),
                      //LatLng(23.80682650343888, 90.36899211099205),

                      //REPLACE WHEN FIREBASE IS READY
                      LatLng(
                    snapshot.data.docs.singleWhere(
                        (element) => element.id == widget.parcelid)['latitude'],
                    snapshot.data.docs.singleWhere((element) =>
                        element.id == widget.parcelid)['longitude'],
                  ),
                  zoom: 14.47),
              onMapCreated: (GoogleMapController controller) async {
                setState(() {
                  _controller = controller;
                  _added = true;
                });
              },
            );
        },
      ),

      // GoogleMap(
      //   mapType: MapType.normal,
      //   markers: {
      //     Marker(
      //         position: LatLng(23.80682650343888, 90.36899211099205),

      //         // REPLACE WITH ACTUAL CODE

      //         // LatLng(
      //         //   snapshot.data.docs.singleWhere(
      //         //       (element) => element.id == widget.parcelid)['latitude'],
      //         //   snapshot.data.docs.singleWhere(
      //         //       (element) => element.id == widget.parcelid)['longitude'],
      //         // ),

      //         // REPLACE WITH ACTUAL CODE

      //         markerId: MarkerId('id'),
      //         icon: BitmapDescriptor.defaultMarkerWithHue(
      //             BitmapDescriptor.hueGreen)),
      //   },
      //   initialCameraPosition: CameraPosition(
      //       target: LatLng(23.80682650343888, 90.36899211099205),

      //       //REPLACE WHEN FIREBASE IS READY
      //       // LatLng(
      //       //   snapshot.data.docs.singleWhere(
      //       //       (element) => element.id == widget.parcelid)['latitude'],
      //       //   snapshot.data.docs.singleWhere(
      //       //       (element) => element.id == widget.parcelid)['longitude'],
      //       // ),

      //       zoom: 14.47),
      //   onMapCreated: (GoogleMapController controller) async {
      //     setState(() {
      //       _controller = controller;
      //       // _added = true;
      //     });
      //   },
      // ),
    );
  }

  Future<void> mymap(snapshot) async {
    await _controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target:
                // LatLng(lat, long),
                // LatLng(23.80682650343888, 90.36899211099205),

                // REPLACE WHEN FIREBASE IS READY
                LatLng(
              snapshot.data.docs.singleWhere(
                  (element) => element.id == widget.parcelid)['latitude'],
              snapshot.data.docs.singleWhere(
                  (element) => element.id == widget.parcelid)['longitude'],
            ),
            zoom: 14.47)));
  }
}

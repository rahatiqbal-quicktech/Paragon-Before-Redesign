import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class AnotherTrack extends StatefulWidget {
  var parcelid;
  AnotherTrack(this.parcelid);

  @override
  _AnotherTrackState createState() => _AnotherTrackState();
}

class _AnotherTrackState extends State<AnotherTrack> {
  //
  final loc.Location location = loc.Location();
  GoogleMapController _controller;
  bool _added = false;
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

      //

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('location')
            .doc(widget.parcelid)
            .snapshots(),
        // ignore: missing_return
        builder: (context, snapshot) {
          //
          // try {
          //   if (snapshot.hasData) {
          //     final values = snapshot.data;
          //     final lat = values['latitude'];
          //     final long = values['longitude'];
          //   }
          // } catch (e) {}

          if (_added) {
            mymap(snapshot);
          }
          try {
            if (!snapshot.hasData) {
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
            }
            if (snapshot.hasData) {
              // return GoogleMap();
              return GoogleMap(
                mapType: MapType.normal,
                markers: {
                  Marker(
                      position: LatLng(snapshot.data['latitude'],
                          snapshot.data['longitude']),
                      markerId: MarkerId('id'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueMagenta)),
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        snapshot.data['latitude'], snapshot.data['longitude']),
                    zoom: 14.47),
                onMapCreated: (GoogleMapController controller) async {
                  setState(() {
                    _controller = controller;
                    _added = true;
                  });
                },
              );
            }
          } catch (e) {
            print(e);
          }

          return Container(
            alignment: Alignment.center,
            child: Text(
              "Parcel is yet to be assigned",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
          );

          // return Center(
          //   child: Column(
          //     children: [
          //       CircularProgressIndicator(),
          //       SizedBox(
          //         height: 20,
          //       ),
          //       Text(
          //         "Parcel is yet to be assigned",
          //         style: TextStyle(
          //           fontSize: 20,
          //           color: Colors.black87,
          //         ),
          //       )
          //     ],
          //   ),
          // );
        },
      ),
    );
  }

  Future<void> mymap(snapshot) async {
    await _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target:
                LatLng(snapshot.data['latitude'], snapshot.data['longitude']),
            zoom: 14.47)));
  }
}

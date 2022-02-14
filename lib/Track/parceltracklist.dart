// import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier/GlobalUtils/UI_Colors.dart';
import 'package:courier/Merchant/Utils/MerchantBottomBar.dart';
import 'package:courier/Merchant/Utils/NavigationDrawer.dart';
import 'package:courier/Models/ParcelModel.dart';
import 'package:courier/Network/MerchantNetwork.dart';
import 'package:courier/Track/anothertrack.dart';
import 'package:courier/Track/track.dart';
// import 'package:courier/Track/track.dart';
import 'package:flutter/material.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:location/location.dart' as loc;
// import 'package:permission_handler/permission_handler.dart';

class ParcelTrackList extends StatefulWidget {
  // const ParcelTrackList({ Key? key }) : super(key: key);

  @override
  _ParcelTrackListState createState() => _ParcelTrackListState();
}

class _ParcelTrackListState extends State<ParcelTrackList> {
  //Copied Codes from Parcels.dart
  List<ParcelModel> parcels = [];
  int startFrom = 0;

  bool isData = true;
  bool isLoading = false;

  void initState() {
    getData();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<bool> getData() async {
    if (!isLoading) {
      if (isData) {
        setState(() {
          isLoading = true;
        });
        await MerchantNetwork().getParcels(startFrom).then((value) {
          if (value.length < 20) {
            isData = false;
          }
          setState(() {
            parcels = value;
            isLoading = false;
          });
        });
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black87),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Get.back(),
          ),
          title: Text(
            "Parcels",
            style: TextStyle(color: Colors.black87),
          )),
      backgroundColor: UIColors.backgroundnew,
      endDrawer: NavigationDrawer(),
      bottomNavigationBar: MerchantBottomBar(),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('location')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Center(
                        child: Text(
                          "There is no parcel in transit.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      // CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 8.5, right: 8.5),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(AnotherTrack(snapshot.data.docs[index].id));
                        },
                        child: SizedBox(
                          height: 100,
                          child:
                              // Text(index.toString()),
                              Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  padding: EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.77),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Parcel ID",
                                        // snapshot.data.docs[index]['parcelid'].toString(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        // "$index",
                                        snapshot.data.docs[index]['parcelid']
                                            .toString(),

                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // width: MediaQuery.of(context).size.width / 1.9,
                                  // height: double.infinity,
                                ),
                              ),
                              Expanded(
                                // flex: 1,
                                flex: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade300,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on_sharp,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "See On Map",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      )
                                    ],
                                  ),
                                  height: double.infinity,
                                  // width: MediaQuery.of(context).size,
                                  // width: double.infinity,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 5,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }


  Widget boilerplate() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 8.5, right: 8.5),
      itemCount: 5,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: null,
          child: SizedBox(
            height: 100,
            child:
                // Text(index.toString()),
                Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.77),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Parcel ID",
                          // snapshot.data.docs[index]['parcelid'].toString(),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$index",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // width: MediaQuery.of(context).size.width / 1.9,
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  // flex: 1,
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_sharp,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "See On Map",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )
                      ],
                    ),
                    height: double.infinity,
                    // width: MediaQuery.of(context).size,
                    // width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 5,
      ),
    );
  }
}

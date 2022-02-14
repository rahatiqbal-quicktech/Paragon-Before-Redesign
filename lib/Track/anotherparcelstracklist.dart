import 'package:courier/GlobalUtils/UI_Colors.dart';
import 'package:courier/Merchant/Utils/MerchantBottomBar.dart';
import 'package:courier/Merchant/Utils/NavigationDrawer.dart';
import 'package:courier/Models/ParcelModel.dart';
import 'package:courier/Network/MerchantNetwork.dart';
import 'package:courier/Track/anothertrack.dart';
import 'package:courier/Track/track.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnotherParcelsTrackList extends StatefulWidget {
  const AnotherParcelsTrackList({Key key}) : super(key: key);

  @override
  _AnotherParcelsTrackListState createState() =>
      _AnotherParcelsTrackListState();
}

class _AnotherParcelsTrackListState extends State<AnotherParcelsTrackList> {
  //
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

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
      //
      backgroundColor: UIColors.backgroundnew,
      endDrawer: NavigationDrawer(),
      bottomNavigationBar: MerchantBottomBar(),
      //
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.maxScrollExtent == scrollInfo.metrics.pixels) {
            getData();
          }
          return true;
        },
        child: parcels.length == 0 && isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : parcels.length == 0
                ? Center(
                    child: Text("No Parcel Available"),
                  )
                : RefreshIndicator(
                    onRefresh: () {
                      setState(() {
                        parcels.clear();
                        startFrom = 0;
                        isData = true;
                      });
                      return getData();
                    },
                    child: SingleChildScrollView(
                        padding: EdgeInsets.all(5),
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            ListView.separated(
                              separatorBuilder: (context, index) {
                                return Divider(
                                  height: 10,
                                );
                              },
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: parcels.length,
                              itemBuilder: (BuildContext context, int index) {
                                startFrom = parcels.length;
                                return parcelItem(parcels[index]);
                              },
                            ),
                            if (isLoading)
                              Center(
                                child: CircularProgressIndicator(),
                              )
                          ],
                        )),
                  ),
      ),
    );
  }

  Widget parcelItem(ParcelModel item) {
    return InkWell(
      onTap: () {
        Get.to(AnotherTrack(item.trackingCode));
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
                      // "$index",
                      // snapshot.data.docs[index]['parcelid'].toString(),
                      item.trackingCode.toString(),

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
  }
}

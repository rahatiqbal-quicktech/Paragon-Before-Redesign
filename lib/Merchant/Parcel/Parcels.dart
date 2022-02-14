/*
Author: QuickTech IT
Author URI: http://quicktech-ltd.com;
Description: QuickTech IT maintain standard quality for Website and Creative Design
*/

import 'package:courier/GlobalUtils/UI_Colors.dart';
import 'package:courier/Merchant/Utils/MerchantBottomBar.dart';
import 'package:courier/Merchant/Utils/NavigationDrawer.dart';
import 'package:courier/Models/ParcelModel.dart';
import 'package:courier/Network/MerchantNetwork.dart';
import 'package:courier/Track/track.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// ignore: camel_case_types
class QuickTechIT_Parcels extends StatefulWidget {
  @override
  _QuickTechIT_ParcelsState createState() => _QuickTechIT_ParcelsState();
}

// ignore: camel_case_types
class _QuickTechIT_ParcelsState extends State<QuickTechIT_Parcels> {
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
        extendBody: true,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: UIColors.primaryColor,
            iconTheme: IconThemeData(color: Colors.white),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
            title: Text(
              "Parcels",
              style: TextStyle(color: Colors.white),
            )),
        backgroundColor: UIColors.backgroundnew,
        endDrawer: NavigationDrawer(),
        bottomNavigationBar: MerchantBottomBar(),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.maxScrollExtent ==
                scrollInfo.metrics.pixels) {
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
                              ListView.builder(
                                // separatorBuilder: (context, index) {
                                //   return Divider(
                                //     height: 1,
                                //   );
                                // },
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
        ));
  }

  Widget parcelItem(ParcelModel item) {
    return InkWell(
        onTap: () {
          Get.toNamed('/merchant/parcel/details/${item.id}');
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Track(item.id.toString())),
          // );
        },
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.35),
                blurRadius: 4,
                offset: Offset(4, 4), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: Get.width,
                child: Text(
                  item.recipientName,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                width: Get.width,
                child: Text(
                  "Mob : ${item.recipientPhone}",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "COD=${item.cod} \nCharge=${item.deliveryCharge}",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                      item.merchantpayStatus == "2"
                          ? "Paid"
                          : item.merchantpayStatus == "1"
                              ? "Processing"
                              : "Unpaid",
                      style: TextStyle(
                        fontSize: 15,
                        color: UIColors.primaryColor,
                      ))
                ],
              ),
              SizedBox(
                height: 6.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    GetStorage().read(item.status.toString()),
                    style:
                        TextStyle(fontSize: 16, color: UIColors.primaryColor),
                  ),
                  Text(
                    item.updatedAt,
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

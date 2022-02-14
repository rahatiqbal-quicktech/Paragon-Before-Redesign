/*
Author: QuickTech IT
Author URI: http://quicktech-ltd.com;
Description: QuickTech IT maintain standard quality for Website and Creative Design
*/

import 'package:courier/GlobalUtils/Decoration.dart';
import 'package:courier/GlobalUtils/UI_Colors.dart';
import 'package:courier/Merchant/Utils/MerchantBottomBar.dart';
import 'package:courier/Merchant/Utils/NavigationDrawer.dart';
import 'package:courier/Models/CodChargeModel.dart';
import 'package:courier/Models/NearestZoneModel.dart';
import 'package:courier/Models/ServicesModel.dart';
import 'package:courier/Network/MerchantNetwork.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

// ignore: camel_case_types
class QuickTechIT_CreateParcel extends StatefulWidget {
  @override
  _QuickTechIT_CreateParcelState createState() =>
      _QuickTechIT_CreateParcelState();
}

// ignore: camel_case_types
class _QuickTechIT_CreateParcelState extends State<QuickTechIT_CreateParcel> {
  // String slug = Get.parameters['slug'];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController customerNameController = new TextEditingController();
  TextEditingController customerPhoneController = new TextEditingController();
  TextEditingController deliveryAddressController = new TextEditingController();
  TextEditingController invoiceController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  TextEditingController cashCollectionController = new TextEditingController();
  TextEditingController productPriceController = new TextEditingController();
  TextEditingController noteController = new TextEditingController();

  List<String> parcelType = ['Regular', 'Liquid']; // Option 2
  int _selectedParcelType;

  List<NearestZoneModel> deliveryArea = []; // Option 2
  int _selectedDeliveryArea;

  List<ServicesModel> services = [];
  ServicesModel selectedService;
  CodChargeModel codCharge;
  int cashCollection = 0;
  int parcelWeight = 0;

  void initState() {
    MerchantNetwork().getNearestZones().then((value) {
      setState(() {
        deliveryArea = value;
      });
    });

    MerchantNetwork().getServices().then((value) {
      setState(() {
        services = value;
      });
    });

    MerchantNetwork().getCodCharge().then((value) {
      setState(() {
        codCharge = value;
      });
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      primary: true,
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
          "Add New Parcel",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: UIColors.backgroundnew,
      endDrawer: NavigationDrawer(),
      bottomNavigationBar: MerchantBottomBar(),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                    width: Get.width,
                    child: Text("Customer Name",
                        style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UIColors.blackColor),
                        textAlign: TextAlign.left)),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: CustomDecoration().textFieldDecoration(),
                  child: TextFormField(
                    controller: customerNameController,
                    validator: (value) =>
                        value == "" ? "Please enter customer name" : null,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                      hintText: "Customer Name",
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: Get.width,
                    child: Text("Customer Phone Number",
                        style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UIColors.blackColor),
                        textAlign: TextAlign.left)),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: CustomDecoration().textFieldDecoration(),
                  child: TextFormField(
                    controller: customerPhoneController,
                    validator: (phone) {
                      if (phone.length == 0) {
                        return "Please enter phone number";
                      } else if (phone.length != 11)
                        return "Phone number must be 11 digit";
                      else
                        return null;
                    },
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                      hintText: "Customer Phone Number",
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: Get.width,
                    child: Text("Customer Address",
                        style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UIColors.blackColor),
                        textAlign: TextAlign.left)),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 100,
                  decoration: CustomDecoration().textFieldDecoration(),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: deliveryAddressController,
                    validator: (value) =>
                        value == "" ? "Please enter Customer address" : null,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                      hintText: "Customer Address",
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Container(
                //     width: Get.width,
                //     child: Text("Invoice",
                //         style: TextStyle(
                //             fontSize: ResponsiveFlutter.of(context).fontSize(2),
                //             color: UIColors.blackColor),
                //         textAlign: TextAlign.left)),
                // SizedBox(
                //   height: 5,
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.grey),
                //     borderRadius: BorderRadius.circular(2),
                //   ),
                //   child: TextFormField(
                //     controller: invoiceController,
                //     validator: (value) =>
                //         value == "" ? "Please enter invoice number" : null,
                //     keyboardType: TextInputType.number,
                //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                //     decoration: InputDecoration(
                //       contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                //       border: InputBorder.none,
                //       hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                //       hintText: "Invoice Number",
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                Container(
                    width: Get.width,
                    child: Text("Weight",
                        style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UIColors.blackColor),
                        textAlign: TextAlign.left)),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: CustomDecoration().textFieldDecoration(),
                  child: TextFormField(
                    controller: weightController,
                    onChanged: (val) {
                      setState(() {
                        parcelWeight = int.parse(val);
                      });
                      generateParcelCharge();
                    },
                    validator: (value) =>
                        value == "" ? "Please enter parcel weight" : null,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                      hintText: "Weight",
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: Get.width,
                    child: Text("Package",
                        style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UIColors.blackColor),
                        textAlign: TextAlign.left)),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: Get.width,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: CustomDecoration().textFieldDecoration(),
                  child: DropdownButtonFormField(
                    hint: Text(
                      "Select Package",
                      style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context).fontSize(2),
                          color: Colors.grey.withOpacity(.8)),
                    ), // Not necessary for Option 1
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                    ),
                    validator: (value) => value == null
                        ? "Please select your parcel package"
                        : null,
                    isExpanded: true,
                    value: selectedService,
                    onChanged: (newValue) {
                      setState(() {
                        selectedService = newValue;
                      });
                      generateParcelCharge();
                    },
                    items: services.map((ServicesModel value) {
                      return DropdownMenuItem(
                        child: new Text(value.title),
                        value: value,
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: Get.width,
                    child: Text("Parcel Type",
                        style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UIColors.blackColor),
                        textAlign: TextAlign.left)),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: Get.width,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: CustomDecoration().textFieldDecoration(),
                  child: DropdownButtonFormField(
                    hint: Text(
                      "Select",
                      style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context).fontSize(2),
                          color: Colors.grey.withOpacity(.8)),
                    ), // Not necessary for Option 1
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                    ),
                    validator: (value) =>
                        value == null ? "Please select your parcel type" : null,
                    isExpanded: true,
                    value: _selectedParcelType,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedParcelType = newValue;
                      });
                      generateParcelCharge();
                    },
                    items: parcelType.map((value) {
                      return DropdownMenuItem(
                        child: new Text(value),
                        value: parcelType.indexOf(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: Get.width,
                    child: Text("Cash Collection Amount",
                        style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UIColors.blackColor),
                        textAlign: TextAlign.left)),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: CustomDecoration().textFieldDecoration(),
                  child: TextFormField(
                    controller: cashCollectionController,
                    onChanged: (val) {
                      setState(() {
                        cashCollection =
                            int.tryParse(val) ?? (cashCollection = 0);
                      });
                      generateParcelCharge();
                    },
                    validator: (value) =>
                        value == "" ? "Please enter Amount" : null,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                      hintText: "Cash Collection Amount",
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Container(
                //     width: Get.width,
                //     child: Text("Product Price",
                //         style: TextStyle(
                //             fontSize: ResponsiveFlutter.of(context).fontSize(2),
                //             color: UIColors.blackColor),
                //         textAlign: TextAlign.left)),
                // SizedBox(
                //   height: 5,
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.grey),
                //     borderRadius: BorderRadius.circular(2),
                //   ),
                //   child: TextFormField(
                //     controller: productPriceController,
                //     validator: (value) =>
                //         value == "" ? "Please enter Product price" : null,
                //     keyboardType: TextInputType.number,
                //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                //     decoration: InputDecoration(
                //       contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                //       border: InputBorder.none,
                //       hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                //       hintText: "Product Price",
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                Container(
                    width: Get.width,
                    child: Text("Delivery Area",
                        style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UIColors.blackColor),
                        textAlign: TextAlign.left)),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: Get.width,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: CustomDecoration().textFieldDecoration(),
                  child: DropdownButtonFormField(
                    hint: Text(
                      "Delivery Area",
                      style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context).fontSize(2),
                          color: Colors.grey.withOpacity(.8)),
                    ), // Not necessary for Option 1
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                    ),
                    validator: (value) =>
                        value == null ? "Please select delivery area" : null,
                    isExpanded: true,
                    value: _selectedDeliveryArea,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedDeliveryArea = newValue;
                      });
                    },
                    items: deliveryArea.map((NearestZoneModel value) {
                      return DropdownMenuItem(
                        child: new Text(value.zonename),
                        value: value.id,
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: Get.width,
                    child: Text("Note",
                        style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UIColors.blackColor),
                        textAlign: TextAlign.left)),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 100,
                  decoration: CustomDecoration().textFieldDecoration(),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: noteController,
                    // validator: (value) => value == "" ? "Note" : null,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                      hintText: "Note",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                deliveryChargeDetails(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: Get.width,
                  decoration: CustomDecoration().buttonDecoration(),
                  child: TextButton(
                    style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(8.0))),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        String name = customerNameController.text;
                        String phoneNumber = customerPhoneController.text;
                        String address = deliveryAddressController.text;
                        String invoiceNo = invoiceController.text;
                        String weight = weightController.text;
                        int parcelType = _selectedParcelType + 1;
                        String cod = cashCollectionController.text;
                        String productPrice = productPriceController.text;
                        int receiveZone = _selectedDeliveryArea;
                        String note = noteController.text;
                        int deliveryCharge = selectedService.deliverycharge;
                        int extraDeliveryCharge =
                            selectedService.extradeliverycharge;
                        int codCharge = this.codCharge.codcharge;
                        int orderType = selectedService.id;
                        int codType = this.codCharge.id;

                        MerchantNetwork().createParcel(
                            name,
                            phoneNumber,
                            address,
                            invoiceNo,
                            weight,
                            parcelType,
                            cod,
                            productPrice,
                            receiveZone,
                            note,
                            deliveryCharge,
                            extraDeliveryCharge,
                            codCharge,
                            orderType,
                            codType);
                      }
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context).fontSize(2.2),
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
              ],
            ),
          )),
    );
  }

  int deliveryCharge = 0;
  int total = 0;

  generateParcelCharge() {
    if (selectedService != null) {
      int extraCharge = 0;
      if (parcelWeight > 1) {
        extraCharge = (parcelWeight - 1) * selectedService.extradeliverycharge;
      } else {
        extraCharge = 0;
      }
      setState(() {
        deliveryCharge = selectedService.deliverycharge + extraCharge;
        total = cashCollection - (deliveryCharge + codCharge.codcharge);
      });
    }
  }

  deliveryChargeDetails() {
    return Container(
      width: Get.width,
      color: Colors.grey[300],
      child: Column(
        children: [
          Container(
            width: Get.width,
            padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
            child: Text(
              "Delivery Charge Details",
              style: TextStyle(
                  fontSize: ResponsiveFlutter.of(context).fontSize(2.8)),
              textAlign: TextAlign.center,
            ),
          ),
          Divider(
            thickness: 3,
            color: UIColors.primaryColor,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cash Collection",
                      style: TextStyle(
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(2.2)),
                    ),
                    Text(
                      "$cashCollection Tk",
                      style: TextStyle(
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(2.2)),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivery Charge",
                      style: TextStyle(
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(2.2)),
                    ),
                    Text(
                      "$deliveryCharge Tk",
                      style: TextStyle(
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(2.2)),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "COD Charge",
                      style: TextStyle(
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(2.2)),
                    ),
                    Text(
                      codCharge != null ? "${codCharge.codcharge} Tk" : "0 Tk",
                      style: TextStyle(
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(2.2)),
                    )
                  ],
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2,
            color: UIColors.blackColor,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Payable Amount",
                  style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.2)),
                ),
                Text(
                  "$total Tk",
                  style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.2)),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: Get.width,
            padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: Text(
              "Note : If you pick up a request after 7pm, It will be received the next day",
              style: TextStyle(
                  fontSize: ResponsiveFlutter.of(context).fontSize(2)),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

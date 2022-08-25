import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mypasar/model/config.dart';
import 'package:mypasar/model/user.dart';
import 'package:mypasar/model/product.dart';
import 'package:http/http.dart' as http;

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  final User user;
  const ProductDetailsPage(
      {Key? key, required this.product, required this.user})
      : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late double screenHeight, screenWidth, resWidth;
  var pathAsset = "assets/images/camera.png";
  User user = User(
      userAddress: "",
      userEmail: "",
      userId: 0,
      userName: "",
      otp: 0,
      userDatareg: "",
      userPhone: "");

  @override
  void initState() {
    super.initState();
    _loadOwner();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _loadOwner();
    // });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        children: [
          //flex
          Flexible(
              flex: 4,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: CachedNetworkImage(
                    width: screenWidth,
                    fit: BoxFit.cover,
                    imageUrl: MyConfig.server +
                        "images/products/" +
                        widget.product.productHashImage.toString() +
                        ".png",
                    placeholder: (context, url) =>
                        const LinearProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ))),
          Text(widget.product.productName.toString(),
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Table(
                      columnWidths: const {
                        0: FractionColumnWidth(0.3),
                        1: FractionColumnWidth(0.7)
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      children: [
                        TableRow(children: [
                          const Text('Description',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(widget.product.productDesc.toString()),
                        ]),
                        TableRow(children: [
                          const Text('Price',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("RM " +
                              double.parse(
                                      widget.product.productPrice.toString())
                                  .toStringAsFixed(2)),
                        ]),
                        TableRow(children: [
                          const Text('Quantity',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(widget.product.productQty.toString()),
                        ]),
                        TableRow(children: [
                          const Text('State',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(widget.product.productState.toString()),
                        ]),
                        TableRow(children: [
                          const Text('Locality',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(widget.product.productLoc.toString()),
                        ]),
                        TableRow(children: [
                          const Text('Owner',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(widget.product.productOwnerName.toString()),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Card(
                    elevation: 10,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                              height: 80,
                              width: 80,
                              child: IconButton(
                                  onPressed: () => {_onCallDialog(1)},
                                  icon: const Icon(Icons.phone))),
                          SizedBox(
                              height: 80,
                              width: 80,
                              child: IconButton(
                                  onPressed: () => {_onCallDialog(2)},
                                  icon: const Icon(Icons.message))),
                          SizedBox(
                              height: 80,
                              width: 80,
                              child: IconButton(
                                  onPressed: () => {_onCallDialog(3)},
                                  icon: const Icon(Icons.share))),
                          SizedBox(
                              height: 80,
                              width: 80,
                              child: IconButton(
                                  onPressed: () => {_onCallDialog(4)},
                                  icon:
                                      const Icon(Icons.local_police_outlined))),
                          SizedBox(
                              height: 80,
                              width: 80,
                              child: IconButton(
                                  onPressed: () => {_onCallDialog(5)},
                                  icon: const Icon(Icons.map_outlined))),
                        ],
                      ),
                    ))),
          )
        ],
      ),
    );
  }

  void _onCallDialog(int r) {
    switch (r) {
      case 1:
        _makePhoneCall(user.userPhone.toString());
        break;
      case 2:
        //('2!');
        _sendSms(user.userPhone.toString());
        break;
      case 3:
        // print('3');
        break;
      case 4:
        //print('4');
        break;
      case 5:
        // print('5');
        // _showMapDialogue();
        break;
      default:
      // print('choose a different number!');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'phone',
      path: phoneNumber,
    );
    // ignore: deprecated_member_use
    // await launch(launchUri.toString());
  }

  Future<void> _sendSms(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    // await launch(launchUri.toString());
  }

  int generateIds() {
    var rng = Random();
    int randomInt;
    randomInt = rng.nextInt(100);
    return randomInt;
  }

  // void _showMapDialogue() {
  //   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  //   Completer<GoogleMapController> _controller = Completer();
  //   CameraPosition prlocation = CameraPosition(
  //     target: LatLng(double.parse(widget.product.productLat.toString()),
  //         double.parse(widget.product.productLong.toString())),
  //     zoom: 15.4746,
  //   );

  //   int markerIdVal = generateIds();
  //   MarkerId markerId = MarkerId(markerIdVal.toString());
  //   final Marker marker = Marker(
  //       markerId: markerId,
  //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  //       position: LatLng(
  //         double.parse(widget.product.productLat.toString()),
  //         double.parse(widget.product.productLong.toString()),
  //       ),
  //       infoWindow: InfoWindow(
  //         title: widget.product.productName.toString(),
  //       ));
  //   markers[markerId] = marker;
  //   //showdialog here
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //         title: const Text(
  //           "Location",
  //           style: TextStyle(),
  //         ),
  //         content: SizedBox(
  //           height: screenHeight / 2,
  //           child: GoogleMap(
  //             mapType: MapType.normal,
  //             initialCameraPosition: prlocation,
  //             myLocationEnabled: true,
  //             markers: Set<Marker>.of(markers.values),
  //             onMapCreated: (GoogleMapController controller) {
  //               _controller.complete(controller);
  //             },
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text(
  //               "Close",
  //               style: TextStyle(),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _loadOwner() {
    print(widget.product.productOwner.toString());
    http.post(Uri.parse(MyConfig.server + "php/load_user_msqli.php"), body: {
      "user_id": widget.product.productOwner.toString()
    }).then((response) {
      print(response.body);
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        setState(() {
          user = User.fromJson(jsondata['data']);
        });
      }
    });
  }
}

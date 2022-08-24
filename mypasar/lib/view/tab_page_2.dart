import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mypasar/model/product.dart';
import 'package:mypasar/model/user.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'edit_product_page.dart';
import 'main_page.dart';
import 'new_product_page.dart';
import 'package:http/http.dart' as http;
import 'package:mypasar/model/config.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TabPage2 extends StatefulWidget {
  final User user;
  const TabPage2({Key? key, required this.user}) : super(key: key);

  @override
  State<TabPage2> createState() => _TabPage2State();
}

class _TabPage2State extends State<TabPage2> {
  List productlist = [];
  String titlecenter = "Loading data...";
  late double screenHeight, screenWidth, resWidth;
  final df = '';
  late ScrollController _scrollController;
  int scrollcount = 10;
  int rowcount = 2;
  int numprd = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      rowcount = 3;
    }
    return Scaffold(
        body: productlist.isEmpty
            ? Center(
                child: Text(titlecenter,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)))
            : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text("Your Current Products",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Text(numprd.toString() + " found"),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: rowcount,
                      controller: _scrollController,
                      children: List.generate(scrollcount, (index) {
                        return Card(
                            child: InkWell(
                          onTap: () => {_prodDetails(index)},
                          child: Column(
                            children: [
                              Flexible(
                                flex: 6,
                                child: CachedNetworkImage(
                                  width: screenWidth,
                                  fit: BoxFit.cover,
                                  imageUrl: MyConfig.server +
                                      "images/products/" +
                                      productlist[index]['image_hash_name'] +
                                      ".png",
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  // const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Flexible(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                            truncateString(productlist[index]
                                                    ['product_name']
                                                .toString()),
                                            style: TextStyle(
                                                fontSize: resWidth * 0.045,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            "RM " +
                                                double.parse(productlist[index]
                                                        ['product_price'])
                                                    .toStringAsFixed(2) +
                                                "  -  " +
                                                productlist[index]
                                                    ['product_qty'] +
                                                " in stock",
                                            style: TextStyle(
                                              fontSize: resWidth * 0.03,
                                            )),
                                        const Text("date"),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ));
                      }),
                    ),
                  ),
                ],
              ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.add),
                label: "New Product",
                labelStyle: const TextStyle(color: Colors.black),
                labelBackgroundColor: Colors.white,
                onTap: _newProduct),
          ],
        ));
  }

  // int loadPages(int prlist) {
  //   int itemperpage = 10;
  //   if (prlist <= 10) {
  //     return prlist;
  //   }

  // }

  String truncateString(String str) {
    if (str.length > 15) {
      str = str.substring(0, 15);
      return str + "...";
    } else {
      return str;
    }
  }

  void _loadImagesHash() {}
  void _newProduct() {
    if (widget.user.userId == null) {
      Fluttertoast.showToast(
          msg: "You need to Login before Adding new Product",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                NewProductPage(user: widget.user)));
  }

  _loadProducts() {
    if (widget.user.userEmail == "na") {
      setState(() {
        titlecenter = "Unregistered User";
      });
      return;
    }
    // print(widget.user.userId);
    var userID = "0";
    if (widget.user.userId == null) {
      userID = "0";
    } else {
      userID = widget.user.userId.toString();
    }
    // print(MyConfig.server + "/load_sellers_product.php");
    http.post(Uri.parse(MyConfig.server + "php/load_sellers_product.php"),
        body: {'productOwner': userID}).then((response) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      var temp = parsedJson['codeResponse'];
      if (temp == 200) {
        var extractdata = parsedJson['data'];
        // print(extractdata);
        setState(() {
          productlist = extractdata;
          for (var productlistDetails in productlist) {
            // print("here");
            productlistDetails['check_image_path'] = 0;

            productlistDetails['image_hash_name'] =
                (productlistDetails['image_hash_name'] == null)
                    ? "no_image"
                    : productlistDetails['image_hash_name'];

            // print(File("/php/load_sellers_product.php").existsSync());
          }
          numprd = productlist.length;
          if (scrollcount >= productlist.length) {
            scrollcount = productlist.length;
          }
        });
      } else {
        setState(() {
          titlecenter = "No Data";
        });
      }
    });
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        if (productlist.length > scrollcount) {
          scrollcount = scrollcount + 10;
          if (scrollcount >= productlist.length) {
            scrollcount = productlist.length;
          }
        }
      });
    }
    // if (_scrollController.offset <=
    //         _scrollController.position.minScrollExtent &&
    //     !_scrollController.position.outOfRange) {
    //   setState(() {
    //     message = "reach the top";
    //   });
    // }
  }

  _prodDetails(int index) async {
    productlist[index]['image_hash_name'] =
        (productlist[index]['image_hash_name'] == null)
            ? "no_image"
            : productlist[index]['image_hash_name'];
    Product product = Product(
        productId: productlist[index]['product_id'],
        productName: productlist[index]['product_name'],
        productDesc: productlist[index]['product_desc'],
        productPrice: productlist[index]['product_price'],
        productQty: productlist[index]['product_qty'],
        userEmail: productlist[index]['user_email'],
        productState: productlist[index]['product_state'],
        productLoc: productlist[index]['product_loc'],
        productLat: productlist[index]['product_lat'],
        productLong: productlist[index]['product_long'],
        productDate: productlist[index]['product_date'],
        productHashImage: productlist[index]['image_hash_name']);

    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => EditProductPage(
                  product: product,
                  user: widget.user,
                )));
    _loadProducts();
  }
}

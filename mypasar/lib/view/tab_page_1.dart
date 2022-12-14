import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mypasar/model/config.dart';
import 'package:mypasar/model/product.dart';
import 'package:mypasar/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:mypasar/view/product_details_tab1.dart';

import 'edit_product_page.dart';

class TabPage1 extends StatefulWidget {
  final User user;
  const TabPage1({Key? key, required this.user}) : super(key: key);

  @override
  State<TabPage1> createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> {
  List productlist = [];
  List<Product>? productList;

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
    _loadBuyerProducts();
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
                  child: Text("Products Available",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                                    const LinearProgressIndicator(),
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
    );
  }

  void _loadBuyerProducts() {
    String userID = '0';
    if (widget.user.userId != null) {
      userID = widget.user.userId.toString();
    }
    print(userID);
    http.post(Uri.parse(MyConfig.server + "php/load_all_products_msqli.php"),
        body: {'user_id': userID}).then((response) {
      var jsondata = jsonDecode(response.body);
      print(jsondata);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        print(response.body);
        var extractdata = jsondata['data'];
        if (extractdata['products'] != null) {
          productList = <Product>[];
          extractdata['products'].forEach((v) {
            productList!.add(Product.fromJson(v));
          });
        }
        setState(() {
          productlist = extractdata["products"];
          numprd = productlist.length;
          if (scrollcount >= productlist.length) {
            scrollcount = productlist.length;
          }
        });
      } else {
        setState(() {
          titlecenter = "No Product Available";
        });
      }
    });
  }

  String truncateString(String str) {
    if (str.length > 15) {
      str = str.substring(0, 15);
      return str + "...";
    } else {
      return str;
    }
  }

  _prodDetails(int index) {
    productlist[index]['image_hash_name'] =
        (productlist[index]['image_hash_name'] == null)
            ? "no_image"
            : productlist[index]['image_hash_name'];
    Product product = Product(
      productId: productlist[index]['product_id'],
      productOwner: productlist[index]['product_owner'],
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
      productOwnerName: productlist[index]['user_join_username'],
      productHashImage: productlist[index]['image_hash_name'],
    );
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                ProductDetailsPage(product: product, user: widget.user)));
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
  }
}

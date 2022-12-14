import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypasar/model/config.dart';
import 'package:mypasar/model/product.dart';
import 'package:mypasar/model/user.dart';
import 'package:ndialog/ndialog.dart';
import 'package:http/http.dart' as http;

class EditProductPage extends StatefulWidget {
  final Product product;
  final User user;

  const EditProductPage({Key? key, required this.product, required this.user})
      : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late double screenHeight, screenWidth, resWidth;
  File? _image;
  var pathAsset = "assets/images/camera.png";
  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  bool editForm = false;
  bool _isChecked = false;

  final TextEditingController _prnameEditingController =
      TextEditingController();
  final TextEditingController _prdescEditingController =
      TextEditingController();
  final TextEditingController _prpriceEditingController =
      TextEditingController();
  final TextEditingController _prdelEditingController = TextEditingController();
  final TextEditingController _prqtyEditingController = TextEditingController();
  final TextEditingController _prstateEditingController =
      TextEditingController();
  final TextEditingController _prlocalEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _prnameEditingController.text = widget.product.productName.toString();
    _prdescEditingController.text = widget.product.productDesc.toString();
    _prpriceEditingController.text = widget.product.productPrice.toString();
    _prqtyEditingController.text = widget.product.productQty.toString();
    _prstateEditingController.text = widget.product.productState.toString();
    _prlocalEditingController.text = widget.product.productLoc.toString();
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
        title: const Text('Your Product Details'),
        actions: [
          IconButton(onPressed: _onDeletePr, icon: const Icon(Icons.delete)),
          IconButton(onPressed: _onEditForm, icon: const Icon(Icons.edit))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: resWidth,
            child: Column(
              children: [
                SizedBox(
                    height: screenHeight / 2.5,
                    child: GestureDetector(
                      onTap: _selectImage,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Container(
                            decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _image == null
                                ? NetworkImage(MyConfig.server +
                                    "images/products/" +
                                    widget.product.productHashImage.toString() +
                                    ".png")
                                : FileImage(_image!) as ImageProvider,
                            fit: BoxFit.fill,
                          ),
                        )),
                      ),
                    )),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                              textInputAction: TextInputAction.next,
                              enabled: editForm,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? "Product name must be longer than 3"
                                      : null,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context).requestFocus(focus);
                              },
                              controller: _prnameEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Product Name',
                                  labelStyle: TextStyle(),
                                  icon: Icon(
                                    Icons.person,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ))),
                          TextFormField(
                              textInputAction: TextInputAction.next,
                              enabled: editForm,
                              validator: (val) => val!.isEmpty ||
                                      (val.length < 3)
                                  ? "Product description must be longer than 3"
                                  : null,
                              focusNode: focus,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context).requestFocus(focus1);
                              },
                              maxLines: 4,
                              controller: _prdescEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Product Description',
                                  alignLabelWithHint: true,
                                  labelStyle: TextStyle(),
                                  icon: Icon(
                                    Icons.person,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ))),
                          Row(
                            children: [
                              Flexible(
                                flex: 5,
                                child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    enabled: editForm,
                                    validator: (val) => val!.isEmpty
                                        ? "Product price must contain value"
                                        : null,
                                    focusNode: focus1,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(focus2);
                                    },
                                    controller: _prpriceEditingController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        labelText: 'Product Price',
                                        labelStyle: TextStyle(),
                                        icon: Icon(
                                          Icons.money,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2.0),
                                        ))),
                              ),
                              Flexible(
                                flex: 5,
                                child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    enabled: editForm,
                                    validator: (val) => val!.isEmpty
                                        ? "Quantity should be more than 0"
                                        : null,
                                    focusNode: focus2,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(focus3);
                                    },
                                    controller: _prqtyEditingController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        labelText: 'Product Quantity',
                                        labelStyle: TextStyle(),
                                        icon: Icon(
                                          Icons.ad_units,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2.0),
                                        ))),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 5,
                                child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    validator: (val) =>
                                        val!.isEmpty || (val.length < 3)
                                            ? "Current State"
                                            : null,
                                    enabled: false,
                                    controller: _prstateEditingController,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        labelText: 'Current States',
                                        labelStyle: TextStyle(),
                                        icon: Icon(
                                          Icons.flag,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2.0),
                                        ))),
                              ),
                              Flexible(
                                  flex: 5,
                                  child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      enabled: false,
                                      validator: (val) =>
                                          val!.isEmpty || (val.length < 3)
                                              ? "Current Locality"
                                              : null,
                                      controller: _prlocalEditingController,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                          labelText: 'Current Locality',
                                          labelStyle: TextStyle(),
                                          icon: Icon(
                                            Icons.map,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 2.0),
                                          )))),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: CheckboxListTile(
                              title:
                                  const Text("Lawfull Item?"), //    <-- label
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Visibility(
                            visible: editForm,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize:
                                      Size(resWidth / 2, resWidth * 0.1)),
                              child: const Text('Update Product'),
                              onPressed: _updateProductDialog,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    if (editForm) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
              title: const Text(
                "Select from",
                style: TextStyle(),
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(resWidth * 0.2, resWidth * 0.2)),
                    child: const Text('Gallery'),
                    onPressed: () => {
                      Navigator.of(context).pop(),
                      _selectfromGallery(),
                    },
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(resWidth * 0.2, resWidth * 0.2)),
                    child: const Text('Camera'),
                    onPressed: () => {
                      Navigator.of(context).pop(),
                      _selectFromCamera(),
                    },
                  ),
                ],
              ));
        },
      );
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth: 800,
      );
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _cropImage();
      } else {
        print('No image selected.');
      }
    }
  }

  Future<void> _selectfromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    } else {
      print('No image selected.');
    }
  }

  Future<void> _selectFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    } else {
      print('No image selected.');
    }
  }

  // Future<void> _cropImage() async {
  //   // File? croppedFile = await ImageCropper.cropImage(
  //   //     sourcePath: _image!.path,
  //   //     aspectRatioPresets: Platform.isAndroid
  //   //         ? [
  //   //             CropAspectRatioPreset.square,
  //   //             CropAspectRatioPreset.ratio3x2,
  //   //           ]
  //   //         : [
  //   //             CropAspectRatioPreset.square,
  //   //           ],
  //   //     androidUiSettings: const AndroidUiSettings(
  //   //         toolbarTitle: 'Crop',
  //   //         toolbarColor: Colors.deepOrange,
  //   //         initAspectRatio: CropAspectRatioPreset.square,
  //   //         lockAspectRatio: false),
  //   //     iosUiSettings: const IOSUiSettings(
  //   //       title: 'Crop Image',
  //   //     ));
  //   // if (croppedFile != null) {
  //   //   _image = croppedFile;
  //   //   setState(() {});
  //   // }
  // }

  void _onEditForm() {
    if (!editForm) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Edit this product",
              style: TextStyle(),
            ),
            content: const Text("Are you sure?", style: TextStyle()),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    editForm = true;
                  });
                },
              ),
              TextButton(
                child: const Text(
                  "No",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _updateProductDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Update this product",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _updateProduct();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateProduct() {
    String _prname = _prnameEditingController.text;
    String _prdesc = _prdescEditingController.text;
    String _prprice = _prpriceEditingController.text;
    String _prqty = _prqtyEditingController.text;
    FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Updating product.."),
        title: const Text("Processing..."));
    progressDialog.show();
    var userId = widget.user.userId.toString();
    var productId = widget.product.productId.toString();
    if (_image == null) {
      print("one");
      http.post(Uri.parse(MyConfig.server + "/php/update_product_msqli.php"),
          body: {
            "userid": userId,
            "prid": productId,
            "prname": _prname,
            "prdesc": _prdesc,
            "prprice": _prprice,
            "prqty": _prqty,
          }).then((response) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        var responseCode = parsedJson['code'];
        if (responseCode == 200) {
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0);
          progressDialog.dismiss();
          Navigator.of(context).pop();
          return;
        } else {
          Fluttertoast.showToast(
              msg: "Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0);
          progressDialog.dismiss();
          return;
        }
      });
    } else {
      print("else");
      String base64Image = base64Encode(_image!.readAsBytesSync());
      http.post(Uri.parse(MyConfig.server + "/php/update_product_msqli.php"),
          body: {
            "userid": userId,
            "prid": productId,
            "prname": _prname,
            "prdesc": _prdesc,
            "prprice": _prprice,
            "prqty": _prqty,
            "image": base64Image,
          }).then((response) {
        var jsonData = response.body;
        print(jsonData);
        var parsedJson = json.decode(jsonData);
        var responseCode = parsedJson['code'];
        if (responseCode == 200) {
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0);
          progressDialog.dismiss();
          Navigator.of(context).pop();
          return;
        } else {
          Fluttertoast.showToast(
              msg: "Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0);
          progressDialog.dismiss();
          return;
        }
      });
    }
    progressDialog.dismiss();
  }

  Future<void> _cropImage() async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  void _onDeletePr() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Delete this product",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteProduct();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct() {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Deleting product.."),
        title: const Text("Processing..."));
    progressDialog.show();
    http.post(Uri.parse(MyConfig.server + "php/delete_product_msqli.php"),
        body: {
          "prid": widget.product.productId,
        }).then((response) {
      var data = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        progressDialog.dismiss();
        Navigator.of(context).pop();
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        progressDialog.dismiss();
        return;
      }
    });
  }
}

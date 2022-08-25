class Product {
  String? productId;
  String? productOwner;
  String? productName;
  String? userEmail;
  String? productDesc;
  String? productPrice;
  String? productQty;
  String? productState;
  String? productLoc;
  String? productLat;
  String? productLong;
  String? productDate;
  String? productHashImage;
  String? productOwnerName;

  Product(
      {this.productId,
      this.productOwner,
      this.productName,
      this.userEmail,
      this.productDesc,
      this.productPrice,
      this.productQty,
      this.productState,
      this.productLoc,
      this.productLat,
      this.productLong,
      this.productHashImage,
      this.productOwnerName,
      this.productDate});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productOwner = json['product_owner'];
    productName = json['product_name'];
    userEmail = json['user_email'];
    productDesc = json['product_desc'];
    productPrice = json['product_price'];
    productQty = json['product_qty'];
    productState = json['product_state'];
    productLoc = json['product_loc'];
    productLat = json['product_lat'];
    productLong = json['product_long'];
    productDate = json['product_date'];
    productHashImage = json['image_hash_name'];
    productOwnerName = json['user_join_username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_owner'] = productOwner;
    data['product_name'] = productName;
    data['user_email'] = userEmail;
    data['product_desc'] = productDesc;
    data['product_price'] = productPrice;
    data['product_qty'] = productQty;
    data['product_state'] = productState;
    data['product_loc'] = productLoc;
    data['product_lat'] = productLat;
    data['product_long'] = productLong;
    data['product_date'] = productDate;
    data['image_hash_name'] = productHashImage;
    return data;
  }
}

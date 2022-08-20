class User {
  int? userId;
  String? userEmail;
  String? userName;
  String? userPhone;
  String? userPassword;
  String? userAddress;
  String? userDatareg;
  int? otp;

  User(
      {this.userId,
      this.userEmail,
      this.userName,
      this.userPhone,
      this.userPassword,
      this.userAddress,
      this.userDatareg,
      this.otp});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userEmail = json['user_email'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    userPassword = json['user_password'];
    userAddress = json['user_address'];
    userDatareg = json['user_datareg'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = userId;
    data['user_email'] = userEmail;
    data['user_name'] = userName;
    data['user_phone'] = userPhone;
    data['user_password'] = userPassword;
    data['user_address'] = userAddress;
    data['user_datareg'] = userDatareg;
    data['otp'] = otp;
    return data;
  }
}

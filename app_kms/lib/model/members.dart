class Members {
  int? id;
  String? employeeCode;
  String? employeeName;
  String? firstname;
  String? mbrEmail;
  String? lastname;
  String? nickname;
  String? department;
  String? position;
  String? username;
  String? status;
  int? isdelete;

  Members(
      {this.id,
      this.employeeName,
      this.employeeCode,
      this.firstname,
      this.mbrEmail,
      this.lastname,
      this.nickname,
      this.department,
      this.position,
      this.username,
      this.status,
      this.isdelete});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeName = json['employee_name'];
    employeeCode = json['employee_code'];
    firstname = json['firstname'];
    mbrEmail = json['mbr_email'];
    lastname = json['lastname'];
    nickname = json['nickname'];
    department = json['department'];
    position = json['position'];
    username = json['username'];
    status = json['status'];
    isdelete = json['isdelete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['employee_code'] = employeeCode;
    data['firstname'] = firstname;
    data['mbr_email'] = mbrEmail;
    data['lastname'] = lastname;
    data['nickname'] = nickname;
    data['department'] = department;
    data['position'] = position;
    data['username'] = username;
    data['status'] = status;
    data['isdelete'] = isdelete;
    return data;
  }
}

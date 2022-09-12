class AssetList {
  String? id;
  String? deviceName;
  String? buyDate;
  String? description;
  String? warrantyStart;
  String? warrantyEnd;
  String? supplier;
  String? poName;
  String? createdBy;
  String? ram;
  String? capacity;
  String? processor;
  String? serialNumber;
  String? department;

  AssetList(
      {this.id,
      this.deviceName,
      this.buyDate,
      this.description,
      this.warrantyStart,
      this.warrantyEnd,
      this.supplier,
      this.poName,
      this.createdBy,
      this.ram,
      this.capacity,
      this.processor,
      this.serialNumber,
      this.department});

  AssetList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceName = json['device_name'];
    buyDate = json['buy_date'];
    description = json['description'];
    warrantyStart = json['warranty_start'];
    warrantyEnd = json['warranty_end'];
    supplier = json['supplier'];
    poName = json['po_name'];
    createdBy = json['created_by'];
    ram = json['ram'];
    capacity = json['capacity'];
    processor = json['processor'];
    serialNumber = json['serial_number'];
    department = json['department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['device_name'] = this.deviceName;
    data['buy_date'] = this.buyDate;
    data['description'] = this.description;
    data['warranty_start'] = this.warrantyStart;
    data['warranty_end'] = this.warrantyEnd;
    data['supplier'] = this.supplier;
    data['po_name'] = this.poName;
    data['created_by'] = this.createdBy;
    data['ram'] = this.ram;
    data['capacity'] = this.capacity;
    data['processor'] = this.processor;
    data['serial_number'] = this.serialNumber;
    data['department'] = this.department;
    return data;
    
  }
}

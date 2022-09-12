class Workorders {
  String? iD;
  String? workOrderNumber;
  String? workOrderCategoryId;
  String? vendor;
  String? companyId;
  String? date;
  String? projectCode;
  String? descriptionofWork;
  String? scopeofWork;
  String? currency;
  String? currencyRate;
  String? costofWork;
  String? costofMaterial;
  String? claimableAmount;
  String? varationOrder;
  String? paymentTerm;
  String? retentionSum;
  String? defectLiabilityPeriod;
  String? commenceDate;
  String? completionDate;
  String? liquidatedandAscertainedDamages;
  String? safetyEquipment;
  String? insurances;
  String? materialAndWorkmanship;
  String? governmentRequirement;
  String? issueByCompany;
  String? issueBy;
  String? issuedBy2;
  String? note;
  String? pIC;
  String? prepareBy;
  String? projectCoordinator;
  String? projectSitesupervisor;
  String? pNL;
  String? planDay;
  String? bQID;
  String? bQIDShort;
  String? dataEntryDate;
  String? bQMasterContractAmt;
  String? bQClaimAtSite;
  String? bQTotalCost;
  String? bQProfit;
  String? bQUnclaimAmt;
  String? bQVer;
  String? bQPath;
  String? insuranceInfo;
  String? status;
  String? wipStatusTracker;
  String? contractExecutive;
  String? approvalUpdateBy;
  String? approvalUpdateDate;
  String? isdelete;
  String? signedWoDocument;
  String? createdAt;
  String? updatedAt;
  String? voFile;
  String? bqFile;
  String? spanNumber;

  Workorders(
      {this.iD,
      this.workOrderNumber,
      this.workOrderCategoryId,
      this.vendor,
      this.companyId,
      this.date,
      this.projectCode,
      this.descriptionofWork,
      this.scopeofWork,
      this.currency,
      this.currencyRate,
      this.costofWork,
      this.costofMaterial,
      this.claimableAmount,
      this.varationOrder,
      this.paymentTerm,
      this.retentionSum,
      this.defectLiabilityPeriod,
      this.commenceDate,
      this.completionDate,
      this.liquidatedandAscertainedDamages,
      this.safetyEquipment,
      this.insurances,
      this.materialAndWorkmanship,
      this.governmentRequirement,
      this.issueByCompany,
      this.issueBy,
      this.issuedBy2,
      this.note,
      this.pIC,
      this.prepareBy,
      this.projectCoordinator,
      this.projectSitesupervisor,
      this.pNL,
      this.planDay,
      this.bQID,
      this.bQIDShort,
      this.dataEntryDate,
      this.bQMasterContractAmt,
      this.bQClaimAtSite,
      this.bQTotalCost,
      this.bQProfit,
      this.bQUnclaimAmt,
      this.bQVer,
      this.bQPath,
      this.insuranceInfo,
      this.status,
      this.wipStatusTracker,
      this.contractExecutive,
      this.approvalUpdateBy,
      this.approvalUpdateDate,
      this.isdelete,
      this.signedWoDocument,
      this.createdAt,
      this.updatedAt,
      this.voFile,
      this.bqFile,
      this.spanNumber});

  Workorders.fromJson(Map<String, dynamic> json) {
    iD = json['ID'].toString();
    workOrderNumber = json['WorkOrderNumber'].toString();
    workOrderCategoryId = json['work_order_category_id'].toString();
    vendor = json['Vendor'].toString();
    companyId = json['company_id'].toString();
    date = json['Date'].toString();
    projectCode = json['ProjectCode'].toString();
    descriptionofWork = json['DescriptionofWork'].toString();
    scopeofWork = json['ScopeofWork'].toString();
    currency = json['currency'].toString();
    currencyRate = json['currency_rate'].toString();
    costofWork = json['CostofWork'].toString();
    costofMaterial = json['CostofMaterial'].toString();
    claimableAmount = json['Claimable_Amount'].toString();
    varationOrder = json['VarationOrder'].toString();
    paymentTerm = json['PaymentTerm'].toString();
    retentionSum = json['RetentionSum'].toString();
    defectLiabilityPeriod = json['DefectLiabilityPeriod'].toString();
    commenceDate = json['CommenceDate'].toString();
    completionDate = json['CompletionDate'].toString();
    liquidatedandAscertainedDamages =
        json['LiquidatedandAscertainedDamages'].toString();
    safetyEquipment = json['SafetyEquipment'].toString();
    insurances = json['Insurances'].toString();
    materialAndWorkmanship = json['MaterialAndWorkmanship'].toString();
    governmentRequirement = json['GovernmentRequirement'].toString();
    issueByCompany = json['IssueByCompany'].toString();
    issueBy = json['IssueBy'].toString();
    issuedBy2 = json['IssuedBy2'].toString();
    note = json['Note'].toString();
    pIC = json['PIC'].toString();
    prepareBy = json['PrepareBy'].toString();
    projectCoordinator = json['project_coordinator'].toString();
    projectSitesupervisor = json['project_sitesupervisor'].toString();
    pNL = json['PNL'].toString();
    planDay = json['PlanDay'].toString();
    bQID = json['BQID'].toString();
    bQIDShort = json['BQIDShort'].toString();
    dataEntryDate = json['DataEntryDate'].toString();
    bQMasterContractAmt = json['BQMasterContractAmt'].toString();
    bQClaimAtSite = json['BQClaimAtSite'].toString();
    bQTotalCost = json['BQTotalCost'].toString();
    bQProfit = json['BQProfit'].toString();
    bQUnclaimAmt = json['BQUnclaimAmt'].toString();
    bQVer = json['BQVer'].toString();
    bQPath = json['BQPath'].toString();
    insuranceInfo = json['InsuranceInfo'].toString();
    status = json['Status'].toString();
    wipStatusTracker = json['wip_status_tracker'].toString();
    contractExecutive = json['ContractExecutive'].toString();
    approvalUpdateBy = json['approval_update_by'].toString();
    approvalUpdateDate = json['approval_update_date'].toString();
    isdelete = json['isdelete'].toString();
    signedWoDocument = json['signed_wo_document'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    voFile = json['vo_file'].toString();
    bqFile = json['bq_file'].toString();
    spanNumber = json['span_number'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['WorkOrderNumber'] = this.workOrderNumber;
    data['work_order_category_id'] = this.workOrderCategoryId;
    data['Vendor'] = this.vendor;
    data['company_id'] = this.companyId;
    data['Date'] = this.date;
    data['ProjectCode'] = this.projectCode;
    data['DescriptionofWork'] = this.descriptionofWork;
    data['ScopeofWork'] = this.scopeofWork;
    data['currency'] = this.currency;
    data['currency_rate'] = this.currencyRate;
    data['CostofWork'] = this.costofWork;
    data['CostofMaterial'] = this.costofMaterial;
    data['Claimable_Amount'] = this.claimableAmount;
    data['VarationOrder'] = this.varationOrder;
    data['PaymentTerm'] = this.paymentTerm;
    data['RetentionSum'] = this.retentionSum;
    data['DefectLiabilityPeriod'] = this.defectLiabilityPeriod;
    data['CommenceDate'] = this.commenceDate;
    data['CompletionDate'] = this.completionDate;
    data['LiquidatedandAscertainedDamages'] =
        this.liquidatedandAscertainedDamages;
    data['SafetyEquipment'] = this.safetyEquipment;
    data['Insurances'] = this.insurances;
    data['MaterialAndWorkmanship'] = this.materialAndWorkmanship;
    data['GovernmentRequirement'] = this.governmentRequirement;
    data['IssueByCompany'] = this.issueByCompany;
    data['IssueBy'] = this.issueBy;
    data['IssuedBy2'] = this.issuedBy2;
    data['Note'] = this.note;
    data['PIC'] = this.pIC;
    data['PrepareBy'] = this.prepareBy;
    data['project_coordinator'] = this.projectCoordinator;
    data['project_sitesupervisor'] = this.projectSitesupervisor;
    data['PNL'] = this.pNL;
    data['PlanDay'] = this.planDay;
    data['BQID'] = this.bQID;
    data['BQIDShort'] = this.bQIDShort;
    data['DataEntryDate'] = this.dataEntryDate;
    data['BQMasterContractAmt'] = this.bQMasterContractAmt;
    data['BQClaimAtSite'] = this.bQClaimAtSite;
    data['BQTotalCost'] = this.bQTotalCost;
    data['BQProfit'] = this.bQProfit;
    data['BQUnclaimAmt'] = this.bQUnclaimAmt;
    data['BQVer'] = this.bQVer;
    data['BQPath'] = this.bQPath;
    data['InsuranceInfo'] = this.insuranceInfo;
    data['Status'] = this.status;
    data['wip_status_tracker'] = this.wipStatusTracker;
    data['ContractExecutive'] = this.contractExecutive;
    data['approval_update_by'] = this.approvalUpdateBy;
    data['approval_update_date'] = this.approvalUpdateDate;
    data['isdelete'] = this.isdelete;
    data['signed_wo_document'] = this.signedWoDocument;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['vo_file'] = this.voFile;
    data['bq_file'] = this.bqFile;
    data['span_number'] = this.spanNumber;
    return data;
  }
}

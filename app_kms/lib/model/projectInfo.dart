class ProjectInfo {
  String? projectID;
  String? licenseCompany;
  String? consultant;
  String? awardedParty;
  String? poValue;
  String? vendorBulkPrivate;
  String? pOFile;
  String? poNo;
  String? clientPic;
  String? projectCode;
  String? projectShortName;
  String? projectType;
  String? projectTeam;
  String? projectStatus;
  String? projectClient;
  String? mainCon1;
  String? maincon2;
  String? projectTitle;
  String? projectContractNo;
  String? projectTenderNo;
  String? tenderId;
  String? projectContractPeriod;
  String? projectPONo;
  String? contractOriginalValue;
  String? contractVoValue;
  String? tarikhPesanan;
  String? projectCommencementDate;
  String? projectCompletionDate;
  String? contractEot;
  String? projectCloseDate;
  String? projectLiquidityAndDamages;
  String? projectDefectLiabilityPeriod;
  String? projectClientGm;
  String? projectClientKj;
  String? projectClientManager;
  String? projectClientEngineer;
  String? projectClientSupervisor;
  String? projectClientFoman;
  String? projectPreparedBy;
  String? projectDatePrepared;
  String? projectImportantNote;
  String? retention;
  String? entryDate;
  String? zoneCode;
  String? location;
  String? latitude;
  String? longitude;
  String? isdelete;
  String? projectCoordinator;
  String? projectSupervisor;
  String? createdAt;
  String? updatedAt;
  String? projectGrossProfit;
  String? clientAddressFinance;
  String? pmName;
  String? pmCode;
  String? pmStaffCode;
  String? isPm1;
  String? peName;
  String? peCode;
  String? peStaffCode;
  String? isPe1;
  String? seName;
  String? seCode;
  String? seStaffCode;
  String? isSe1;
  String? pdName;
  String? pdCode;
  String? pdStaffCode;
  String? isPd;
  String? hodName;
  String? hodCode;
  String? hodStaffCode;
  String? isHod;

  ProjectInfo(
      {this.projectID,
      this.licenseCompany,
      this.consultant,
      this.awardedParty,
      this.poValue,
      this.vendorBulkPrivate,
      this.pOFile,
      this.poNo,
      this.clientPic,
      this.projectCode,
      this.projectShortName,
      this.projectType,
      this.projectTeam,
      this.projectStatus,
      this.projectClient,
      this.mainCon1,
      this.maincon2,
      this.projectTitle,
      this.projectContractNo,
      this.projectTenderNo,
      this.tenderId,
      this.projectContractPeriod,
      this.projectPONo,
      this.contractOriginalValue,
      this.contractVoValue,
      this.tarikhPesanan,
      this.projectCommencementDate,
      this.projectCompletionDate,
      this.contractEot,
      this.projectCloseDate,
      this.projectLiquidityAndDamages,
      this.projectDefectLiabilityPeriod,
      this.projectClientGm,
      this.projectClientKj,
      this.projectClientManager,
      this.projectClientEngineer,
      this.projectClientSupervisor,
      this.projectClientFoman,
      this.projectPreparedBy,
      this.projectDatePrepared,
      this.projectImportantNote,
      this.retention,
      this.entryDate,
      this.zoneCode,
      this.location,
      this.latitude,
      this.longitude,
      this.isdelete,
      this.projectCoordinator,
      this.projectSupervisor,
      this.createdAt,
      this.updatedAt,
      this.projectGrossProfit,
      this.clientAddressFinance,
      this.pmName,
      this.pmCode,
      this.pmStaffCode,
      this.isPm1,
      this.peName,
      this.peCode,
      this.peStaffCode,
      this.isPe1,
      this.seName,
      this.seCode,
      this.seStaffCode,
      this.isSe1,
      this.pdName,
      this.pdCode,
      this.pdStaffCode,
      this.isPd,
      this.hodName,
      this.hodCode,
      this.hodStaffCode,
      this.isHod});

  ProjectInfo.fromJson(Map<String, dynamic> json) {
    projectID = json['Project_ID'].toString();
    licenseCompany = json['license_company'].toString();
    consultant = json['consultant'].toString();
    awardedParty = json['awarded_party'].toString();
    poValue = json['po_value'].toString();
    vendorBulkPrivate = json['vendor_bulk_private'].toString();
    pOFile = json['PO_file'].toString();
    poNo = json['po_no'].toString();
    clientPic = json['client_pic'].toString();
    projectCode = json['Project_Code'].toString();
    projectShortName = json['Project_Short_name'].toString();
    projectType = json['project_type'].toString();
    projectTeam = json['project_team'].toString();
    projectStatus = json['Project_Status'].toString();
    projectClient = json['Project_Client'].toString();
    mainCon1 = json['MainCon1'].toString();
    maincon2 = json['Maincon2'].toString();
    projectTitle = json['Project_Title'].toString();
    projectContractNo = json['Project_Contract_No'].toString();
    projectTenderNo = json['project_tender_no'].toString();
    tenderId = json['tender_id'].toString();
    projectContractPeriod = json['project_contract_period'].toString();
    projectPONo = json['Project_PO_No'].toString();
    contractOriginalValue = json['contract_original_value'].toString();
    contractVoValue = json['contract_vo_value'].toString();
    tarikhPesanan = json['Tarikh_Pesanan'].toString();
    projectCommencementDate = json['Project_Commencement_Date'].toString();
    projectCompletionDate = json['Project_Completion_Date'].toString();
    contractEot = json['contract_eot'].toString();
    projectCloseDate = json['Project_Close_Date'].toString();
    projectLiquidityAndDamages = json['Project_Liquidity_And_Damages'].toString();
    projectDefectLiabilityPeriod = json['Project_Defect_Liability_Period'].toString();
    projectClientGm = json['project_client_gm'].toString();
    projectClientKj = json['project_client_kj'].toString();
    projectClientManager = json['Project_Client_Manager'].toString();
    projectClientEngineer = json['Project_Client_Engineer'].toString();
    projectClientSupervisor = json['Project_Client_Supervisor'].toString();
    projectClientFoman = json['project_client_foman'].toString();
    projectPreparedBy = json['Project_Prepared_by'].toString();
    projectDatePrepared = json['Project_Date_Prepared'].toString();
    projectImportantNote = json['Project_Important_Note'].toString();
    retention = json['Retention'].toString();
    entryDate = json['EntryDate'].toString();
    zoneCode = json['zone_code'].toString();
    location = json['location'].toString();
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    isdelete = json['isdelete'].toString();
    projectCoordinator = json['Project_Coordinator'].toString();
    projectSupervisor = json['Project_Supervisor'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    projectGrossProfit = json['project_gross_profit'].toString();
    clientAddressFinance = json['client_address_finance'].toString();
    pmName = json['pmName'].toString();
    pmCode = json['pmCode'].toString();
    pmStaffCode = json['pmStaffCode'].toString();
    isPm1 = json['is_pm1'].toString();
    peName = json['peName'].toString();
    peCode = json['peCode'].toString();
    peStaffCode = json['peStaffCode'].toString();
    isPe1 = json['is_pe1'].toString();
    seName = json['seName'].toString();
    seCode = json['seCode'].toString();
    seStaffCode = json['seStaffCode'].toString();
    isSe1 = json['is_se1'].toString();
    pdName = json['pdName'].toString();
    pdCode = json['pdCode'].toString();
    pdStaffCode = json['pdStaffCode'].toString();
    isPd = json['is_pd'].toString();
    hodName = json['hodName'].toString();
    hodCode = json['hodCode'].toString();
    hodStaffCode = json['hodStaffCode'].toString();
    isHod = json['is_hod'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Project_ID'] = this.projectID;
    data['license_company'] = this.licenseCompany;
    data['consultant'] = this.consultant;
    data['awarded_party'] = this.awardedParty;
    data['po_value'] = this.poValue;
    data['vendor_bulk_private'] = this.vendorBulkPrivate;
    data['PO_file'] = this.pOFile;
    data['po_no'] = this.poNo;
    data['client_pic'] = this.clientPic;
    data['Project_Code'] = this.projectCode;
    data['Project_Short_name'] = this.projectShortName;
    data['project_type'] = this.projectType;
    data['project_team'] = this.projectTeam;
    data['Project_Status'] = this.projectStatus;
    data['Project_Client'] = this.projectClient;
    data['MainCon1'] = this.mainCon1;
    data['Maincon2'] = this.maincon2;
    data['Project_Title'] = this.projectTitle;
    data['Project_Contract_No'] = this.projectContractNo;
    data['project_tender_no'] = this.projectTenderNo;
    data['tender_id'] = this.tenderId;
    data['project_contract_period'] = this.projectContractPeriod;
    data['Project_PO_No'] = this.projectPONo;
    data['contract_original_value'] = this.contractOriginalValue;
    data['contract_vo_value'] = this.contractVoValue;
    data['Tarikh_Pesanan'] = this.tarikhPesanan;
    data['Project_Commencement_Date'] = this.projectCommencementDate;
    data['Project_Completion_Date'] = this.projectCompletionDate;
    data['contract_eot'] = this.contractEot;
    data['Project_Close_Date'] = this.projectCloseDate;
    data['Project_Liquidity_And_Damages'] = this.projectLiquidityAndDamages;
    data['Project_Defect_Liability_Period'] = this.projectDefectLiabilityPeriod;
    data['project_client_gm'] = this.projectClientGm;
    data['project_client_kj'] = this.projectClientKj;
    data['Project_Client_Manager'] = this.projectClientManager;
    data['Project_Client_Engineer'] = this.projectClientEngineer;
    data['Project_Client_Supervisor'] = this.projectClientSupervisor;
    data['project_client_foman'] = this.projectClientFoman;
    data['Project_Prepared_by'] = this.projectPreparedBy;
    data['Project_Date_Prepared'] = this.projectDatePrepared;
    data['Project_Important_Note'] = this.projectImportantNote;
    data['Retention'] = this.retention;
    data['EntryDate'] = this.entryDate;
    data['zone_code'] = this.zoneCode;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['isdelete'] = this.isdelete;
    data['Project_Coordinator'] = this.projectCoordinator;
    data['Project_Supervisor'] = this.projectSupervisor;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['project_gross_profit'] = this.projectGrossProfit;
    data['client_address_finance'] = this.clientAddressFinance;
    data['pmName'] = this.pmName;
    data['pmCode'] = this.pmCode;
    data['pmStaffCode'] = this.pmStaffCode;
    data['is_pm1'] = this.isPm1;
    data['peName'] = this.peName;
    data['peCode'] = this.peCode;
    data['peStaffCode'] = this.peStaffCode;
    data['is_pe1'] = this.isPe1;
    data['seName'] = this.seName;
    data['seCode'] = this.seCode;
    data['seStaffCode'] = this.seStaffCode;
    data['is_se1'] = this.isSe1;
    data['pdName'] = this.pdName;
    data['pdCode'] = this.pdCode;
    data['pdStaffCode'] = this.pdStaffCode;
    data['is_pd'] = this.isPd;
    data['hodName'] = this.hodName;
    data['hodCode'] = this.hodCode;
    data['hodStaffCode'] = this.hodStaffCode;
    data['is_hod'] = this.isHod;
    return data;
  }
}

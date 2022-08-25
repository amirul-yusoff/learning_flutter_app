class DailyRecordList {
  String? daily_record_id;
  String? serial_no;
  String? project_code;
  String? daily_record_date;
  String? start_time;
  String? end_time;
  String? shift;
  String? rain_start_time;
  String? rain_end_time;
  String? record_by;
  String? record_date;
  String? site_activity;
  String? problem;
  String? solution;
  String? isdelete;
  String? sync;
  String? longitude;
  String? latitude;
  String? status;
  String? is_idle;
  String? is_late;
  String? approved_by_pe;
  String? review_comment;
  String? pe_approval_date;
  String? approved_by_pm;
  String? created_at;
  String? updated_at;

  DailyRecordList(
      {
      this.daily_record_id,
      this.serial_no,
      this.project_code,
      this.daily_record_date,
      this.start_time,
      this.end_time,
      this.shift,
      this.rain_start_time,
      this.rain_end_time,
      this.record_by,
      this.record_date,
      this.site_activity,
      this.problem,
      this.solution,
      this.isdelete,
      this.sync,
      this.longitude,
      this.latitude,
      this.status,
      this.is_idle,
      this.is_late,
      this.approved_by_pe,
      this.review_comment,
      this.pe_approval_date,
      this.approved_by_pm,
      this.created_at,
      this.updated_at,
      });

  DailyRecordList.fromJson(Map<String, dynamic> json) {
    daily_record_id = json['daily_record_id'];
    serial_no = json['serial_no'];
    project_code = json['project_code'];
    daily_record_date = json['daily_record_date'];
    start_time = json['start_time'];
    end_time = json['end_time'];
    shift = json['shift'];
    rain_start_time = json['rain_start_time'];
    rain_end_time = json['rain_end_time'];
    record_by = json['record_by'];
    record_date = json['record_date'];
    site_activity = json['site_activity'];
    problem = json['problem'];
    solution = json['solution'];
    isdelete = json['isdelete'];
    sync = json['sync'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    status = json['status'];
    is_idle = json['is_idle'];
    is_late = json['is_late'];
    is_late = json['is_late'];
    approved_by_pe = json['approved_by_pe'];
    review_comment = json['review_comment'];
    pe_approval_date = json['pe_approval_date'];
    approved_by_pm = json['approved_by_pm'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['daily_record_id'] = this.daily_record_id;
    data['serial_no'] = this.serial_no;
    data['project_code'] = this.project_code;
    data['daily_record_date'] = this.daily_record_date;
    data['start_time'] = this.start_time;
    data['end_time'] = this.end_time;
    data['shift'] = this.shift;
    data['rain_start_time'] = this.rain_start_time;
    data['rain_end_time'] = this.rain_end_time;
    data['record_by'] = this.record_by;
    data['record_date'] = this.record_date;
    data['site_activity'] = this.site_activity;
    data['problem'] = this.problem;
    data['solution'] = this.solution;
    data['isdelete'] = this.isdelete;
    data['sync'] = this.sync;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['status'] = this.status;
    data['is_idle'] = this.is_idle;
    data['is_late'] = this.is_late;
    data['is_late'] = this.is_late;
    data['approved_by_pe'] = this.approved_by_pe;
    data['review_comment'] = this.review_comment;
    data['pe_approval_date'] = this.pe_approval_date;
    data['approved_by_pm'] = this.approved_by_pm;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    return data;
  }
}

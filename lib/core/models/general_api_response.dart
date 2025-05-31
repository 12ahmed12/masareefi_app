class GeneralApiResponse {
  bool? status;
  int? code;
  String? message;
  dynamic data;

  GeneralApiResponse({this.status, this.code, this.message, this.data});

  GeneralApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
}

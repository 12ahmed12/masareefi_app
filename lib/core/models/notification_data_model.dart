class NotificationDataModel {
  String? deviceToken;
  String? deviceType;
  String? deviceId;

  NotificationDataModel({this.deviceToken, this.deviceType, this.deviceId});

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    deviceToken = json['deviceToken'];
    deviceType = json['deviceType'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceToken'] = deviceToken;
    data['deviceType'] = deviceType;
    data['deviceId'] = deviceId;
    return data;
  }
}

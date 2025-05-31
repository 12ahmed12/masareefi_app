class UserData {
  bool? success;
  bool? isVerified;
  String? fullName;
  String? productName;
  String? token;
  String? message;

  UserData({
    this.fullName,
    this.token,
    this.success,
    this.message,
    this.isVerified,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    productName = json['productName'];
    token = json['token'];
    success = json['success'];
    message = json['message'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'productName': productName,
        'token': token,
        'success': success,
        'message': message,
        'isVerified': isVerified,
      };
}

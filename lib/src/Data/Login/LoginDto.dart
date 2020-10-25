class LoginDto {
  Data data;
  String errorMessage;

  LoginDto({this.data, this.errorMessage});

  LoginDto.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class Data {
  String fullName;
  String username;
  String phoneNumber;
  String email;
  String password;
  int userTypeId;
  String userTypeName;

  Data(
      {this.fullName,
      this.username,
      this.phoneNumber,
      this.email,
      this.password,
      this.userTypeId,
      this.userTypeName});

  Data.fromJson(Map<String, dynamic> json) {
    fullName = json['FullName'];
    username = json['Username'];
    phoneNumber = json['PhoneNumber'];
    email = json['Email'];
    password = json['Password'];
    userTypeId = json['UserTypeId'];
    userTypeName = json['UserTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FullName'] = this.fullName;
    data['Username'] = this.username;
    data['PhoneNumber'] = this.phoneNumber;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['UserTypeId'] = this.userTypeId;
    data['UserTypeName'] = this.userTypeName;
    return data;
  }
}

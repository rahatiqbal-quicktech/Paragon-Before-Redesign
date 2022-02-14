class MerchantModelNew {
  int id;
  String firstName;
  Null lastName;
  Null username;
  String companyName;
  Null pickLocation;
  Null phoneNumber;
  String emailAddress;
  Null nearestZone;
  Null pickupPreference;
  Null socialLink;
  Null paymentMethod;
  Null paymentmode;
  Null withdrawal;
  Null nameOfBank;
  Null bankBranch;
  Null bankAcHolder;
  Null bankAcNo;
  Null bkashNumber;
  Null roketNumber;
  Null nogodNumber;
  Null balance;
  Null passwordReset;
  String logo;
  String agree;
  int verifyToken;
  int status;
  String createdAt;
  String updatedAt;

  MerchantModelNew(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.companyName,
      this.pickLocation,
      this.phoneNumber,
      this.emailAddress,
      this.nearestZone,
      this.pickupPreference,
      this.socialLink,
      this.paymentMethod,
      this.paymentmode,
      this.withdrawal,
      this.nameOfBank,
      this.bankBranch,
      this.bankAcHolder,
      this.bankAcNo,
      this.bkashNumber,
      this.roketNumber,
      this.nogodNumber,
      this.balance,
      this.passwordReset,
      this.logo,
      this.agree,
      this.verifyToken,
      this.status,
      this.createdAt,
      this.updatedAt});

  MerchantModelNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    companyName = json['companyName'];
    pickLocation = json['pickLocation'];
    phoneNumber = json['phoneNumber'];
    emailAddress = json['emailAddress'];
    nearestZone = json['nearestZone'];
    pickupPreference = json['pickupPreference'];
    socialLink = json['socialLink'];
    paymentMethod = json['paymentMethod'];
    paymentmode = json['paymentmode'];
    withdrawal = json['withdrawal'];
    nameOfBank = json['nameOfBank'];
    bankBranch = json['bankBranch'];
    bankAcHolder = json['bankAcHolder'];
    bankAcNo = json['bankAcNo'];
    bkashNumber = json['bkashNumber'];
    roketNumber = json['roketNumber'];
    nogodNumber = json['nogodNumber'];
    balance = json['balance'];
    passwordReset = json['passwordReset'];
    logo = json['logo'];
    agree = json['agree'];
    verifyToken = json['verifyToken'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['companyName'] = this.companyName;
    data['pickLocation'] = this.pickLocation;
    data['phoneNumber'] = this.phoneNumber;
    data['emailAddress'] = this.emailAddress;
    data['nearestZone'] = this.nearestZone;
    data['pickupPreference'] = this.pickupPreference;
    data['socialLink'] = this.socialLink;
    data['paymentMethod'] = this.paymentMethod;
    data['paymentmode'] = this.paymentmode;
    data['withdrawal'] = this.withdrawal;
    data['nameOfBank'] = this.nameOfBank;
    data['bankBranch'] = this.bankBranch;
    data['bankAcHolder'] = this.bankAcHolder;
    data['bankAcNo'] = this.bankAcNo;
    data['bkashNumber'] = this.bkashNumber;
    data['roketNumber'] = this.roketNumber;
    data['nogodNumber'] = this.nogodNumber;
    data['balance'] = this.balance;
    data['passwordReset'] = this.passwordReset;
    data['logo'] = this.logo;
    data['agree'] = this.agree;
    data['verifyToken'] = this.verifyToken;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

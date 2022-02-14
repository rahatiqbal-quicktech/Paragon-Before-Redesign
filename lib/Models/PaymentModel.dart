class PaymentModel {
  int _id;
  int _merchantId;
  int _parcelId;
  String _createdAt;
  String _updatedAt;

  PaymentModel(
      {int id,
        int merchantId,
        int parcelId,
        String createdAt,
        String updatedAt}) {
    this._id = id;
    this._merchantId = merchantId;
    this._parcelId = parcelId;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get merchantId => _merchantId;
  set merchantId(int merchantId) => _merchantId = merchantId;
  int get parcelId => _parcelId;
  set parcelId(int parcelId) => _parcelId = parcelId;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;

  PaymentModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _merchantId = json['merchantId'];
    _parcelId = json['parcelId'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['merchantId'] = this._merchantId;
    data['parcelId'] = this._parcelId;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}

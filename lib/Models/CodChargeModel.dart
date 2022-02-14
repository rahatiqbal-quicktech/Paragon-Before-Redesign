class CodChargeModel {
  int _id;
  int _codcharge;
  int _status;
  String _createdAt;
  String _updatedAt;

  CodChargeModel(
      {int id, int codcharge, int status, String createdAt, String updatedAt}) {
    this._id = id;
    this._codcharge = codcharge;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get codcharge => _codcharge;
  set codcharge(int codcharge) => _codcharge = codcharge;
  int get status => _status;
  set status(int status) => _status = status;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;

  CodChargeModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _codcharge = json['codcharge'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['codcharge'] = this._codcharge;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}

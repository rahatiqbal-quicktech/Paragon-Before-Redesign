class ServicesModel {
  int _id;
  String _title;
  String _slug;
  String _subtitle;
  String _time;
  int _deliverycharge;
  int _extradeliverycharge;
  String _description;
  int _status;
  String _createdAt;
  String _updatedAt;

  ServicesModel(
      {int id,
        String title,
        String slug,
        String subtitle,
        String time,
        int deliverycharge,
        int extradeliverycharge,
        String description,
        int status,
        String createdAt,
        String updatedAt}) {
    this._id = id;
    this._title = title;
    this._slug = slug;
    this._subtitle = subtitle;
    this._time = time;
    this._deliverycharge = deliverycharge;
    this._extradeliverycharge = extradeliverycharge;
    this._description = description;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get title => _title;
  set title(String title) => _title = title;
  String get slug => _slug;
  set slug(String slug) => _slug = slug;
  String get subtitle => _subtitle;
  set subtitle(String subtitle) => _subtitle = subtitle;
  String get time => _time;
  set time(String time) => _time = time;
  int get deliverycharge => _deliverycharge;
  set deliverycharge(int deliverycharge) => _deliverycharge = deliverycharge;
  int get extradeliverycharge => _extradeliverycharge;
  set extradeliverycharge(int extradeliverycharge) =>
      _extradeliverycharge = extradeliverycharge;
  String get description => _description;
  set description(String description) => _description = description;
  int get status => _status;
  set status(int status) => _status = status;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;

  ServicesModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _slug = json['slug'];
    _subtitle = json['subtitle'];
    _time = json['time'];
    _deliverycharge = json['deliverycharge'];
    _extradeliverycharge = json['extradeliverycharge'];
    _description = json['description'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['slug'] = this._slug;
    data['subtitle'] = this._subtitle;
    data['time'] = this._time;
    data['deliverycharge'] = this._deliverycharge;
    data['extradeliverycharge'] = this._extradeliverycharge;
    data['description'] = this._description;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}

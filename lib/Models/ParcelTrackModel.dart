class ParcelTrackModel {
  bool _success;
  String _message;
  List<Data> _data;

  ParcelTrackModel({bool success, String message, List<Data> data}) {
    this._success = success;
    this._message = message;
    this._data = data;
  }

  bool get success => _success;
  set success(bool success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  List<Data> get data => _data;
  set data(List<Data> data) => _data = data;

  ParcelTrackModel.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = new List<Data>();
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int _id;
  int _parcelId;
  String _note;
  String _createdAt;
  String _updatedAt;

  Data(
      {int id, int parcelId, String note, String createdAt, String updatedAt}) {
    this._id = id;
    this._parcelId = parcelId;
    this._note = note;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get parcelId => _parcelId;
  set parcelId(int parcelId) => _parcelId = parcelId;
  String get note => _note;
  set note(String note) => _note = note;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _parcelId = json['parcelId'];
    _note = json['note'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['parcelId'] = this._parcelId;
    data['note'] = this._note;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}

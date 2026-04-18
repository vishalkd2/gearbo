

class RoomModel {
  String? sId;
  int? id;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Guest>? guests;

  RoomModel({
    this.sId,
    this.id,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.guests,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      sId: json['_id'],
      id: json['id'],
      type: json['type'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      guests: json['guests'] != null
          ? (json['guests'] as List).map((g) => Guest.fromJson(g)).toList()
          : [],
    );
  }
}

class Guest {
  String? name;
  String? phone;

  Guest({this.name, this.phone});

  factory Guest.fromJson(Map<String, dynamic> json) {
    return Guest(
      name: json['name'],
      phone: json['phone'],
    );
  }
}